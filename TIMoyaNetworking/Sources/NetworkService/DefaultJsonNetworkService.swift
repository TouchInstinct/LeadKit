//
//  Copyright (c) 2022 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import TINetworking
import Alamofire
import Moya
import TISwiftUtils
import Foundation
import TIFoundationUtils

open class DefaultJsonNetworkService {
    public typealias RequestResult<S: Decodable, AE: Decodable> = EndpointRequestResult<S, AE, MoyaError>

    public var session: Session

    public var serializationQueue: DispatchQueue = .global(qos: .default)
    public var callbackQueue: DispatchQueue = .main

    public var decodableSuccessStatusCodes: Set<Int>? = nil
    public var decodableFailureStatusCodes: Set<Int>? = nil

    public var jsonDecoder: JSONDecoder
    public var jsonEncoder: JSONEncoder

    public var defaultServer: Server

    public var plugins: [PluginType] = []

    public init(session: Session,
                jsonCodingConfigurator: JsonCodingConfigurator,
                defaultServer: Server) {

        self.session = session
        self.jsonDecoder = jsonCodingConfigurator.jsonDecoder
        self.jsonEncoder = jsonCodingConfigurator.jsonEncoder
        self.defaultServer = defaultServer
    }

    open func createProvider() -> MoyaProvider<SerializedRequest> {
        MoyaProvider<SerializedRequest>(callbackQueue: serializationQueue,
                                        session: session,
                                        plugins: plugins)
    }

    open func serialize<B: Encodable, S: Decodable>(request: EndpointRequest<B, S>) throws -> SerializedRequest {
        try request.serialize(using: ApplicationJsonBodySerializer(jsonEncoder: jsonEncoder),
                              defaultServer: defaultServer)
    }

    @available(iOS 13.0.0, *)
    open func process<B: Encodable, S, F>(request: EndpointRequest<B, S>) async -> RequestResult<S, F> {
        await process(request: request,
                      mapSuccess: Result.success,
                      mapFailure: { .failure(.apiError($0)) },
                      mapMoyaError: { .failure(.networkError($0)) })
    }

    @available(iOS 13.0.0, *)
    open func process<B: Encodable, S: Decodable, F: Decodable, R>(request: EndpointRequest<B, S>,
                                                                   mapSuccess: @escaping Closure<S, R>,
                                                                   mapFailure: @escaping Closure<F, R>,
                                                                   mapMoyaError: @escaping Closure<MoyaError, R>) async -> R {

        let cancellableBag = CancellableBag()

        return await withTaskCancellationHandler(handler: {
            cancellableBag.cancel()
        }, operation: {
            await withCheckedContinuation { continuation in
                process(request: request,
                        mapSuccess: mapSuccess,
                        mapFailure: mapFailure,
                        mapMoyaError: mapMoyaError) {

                    continuation.resume(returning: $0)
                }
                        .add(to: cancellableBag)
            }
        })
    }

    open func process<B: Encodable, S: Decodable, F: Decodable, R>(request: EndpointRequest<B, S>,
                                                                   mapSuccess: @escaping Closure<S, R>,
                                                                   mapFailure: @escaping Closure<F, R>,
                                                                   mapMoyaError: @escaping Closure<MoyaError, R>,
                                                                   completion: @escaping ParameterClosure<R>) -> Cancellable {

        ScopeCancellable { [serializationQueue, callbackQueue] scope in
            let workItem = DispatchWorkItem {
                guard !scope.isCancelled else {
                    return
                }

                do {
                    let serializedRequest = try self.serialize(request: request)

                    scope.add(cancellable: self.process(request: serializedRequest,
                                                        mapSuccess: mapSuccess,
                                                        mapFailure: mapFailure,
                                                        mapMoyaError: mapMoyaError,
                                                        completion: completion))
                } catch {
                    callbackQueue.async {
                        completion(mapMoyaError(.encodableMapping(error)))
                    }
                }
            }

            serializationQueue.async(execute: workItem)

            return workItem
        }
    }

    open func process<S: Decodable, F: Decodable, R>(request: SerializedRequest,
                                                     mapSuccess: @escaping Closure<S, R>,
                                                     mapFailure: @escaping Closure<F, R>,
                                                     mapMoyaError: @escaping Closure<MoyaError, R>,
                                                     completion: @escaping ParameterClosure<R>) -> Cancellable {

        createProvider().request(request) { [jsonDecoder,
                                             callbackQueue,
                                             decodableSuccessStatusCodes,
                                             decodableFailureStatusCodes,
                                             plugins] in
            let result: R

            switch $0 {
            case let .success(rawResponse):
                let successStatusCodes: Set<Int>
                let failureStatusCodes: Set<Int>

                switch (decodableSuccessStatusCodes, decodableFailureStatusCodes) {
                case let (successCodes?, failureCodes?):
                    successStatusCodes = successCodes
                    failureStatusCodes = failureCodes

                case let (nil, failureCodes?):
                    successStatusCodes = request.acceptableStatusCodes.subtracting(failureCodes)
                    failureStatusCodes = failureCodes

                case let (successCodes?, nil):
                    successStatusCodes = successCodes
                    failureStatusCodes = request.acceptableStatusCodes.subtracting(successCodes)

                default:
                    successStatusCodes = HTTPCodes.success.asSet() // default success status codes if nothing was passed
                    failureStatusCodes = request.acceptableStatusCodes.subtracting(successStatusCodes)
                }

                let decodeResult = rawResponse.decode(mapping: [
                    ((successStatusCodes, CommonMediaTypes.applicationJson.rawValue), jsonDecoder.decoding(to: mapSuccess)),
                    ((failureStatusCodes, CommonMediaTypes.applicationJson.rawValue), jsonDecoder.decoding(to: mapFailure)),
                ])

                let pluginResult: Result<Response, MoyaError>

                switch decodeResult {
                case let .success(model):
                    result = model
                    pluginResult = .success(rawResponse)
                case let .failure(moyaError):
                    result = mapMoyaError(moyaError)
                    pluginResult = .failure(moyaError)
                }

                plugins.forEach {
                    $0.didReceive(pluginResult, target: request)
                }
            case let .failure(moyaError):
                result = mapMoyaError(moyaError)
            }

            callbackQueue.async {
                completion(result)
            }
        }
    }
}
