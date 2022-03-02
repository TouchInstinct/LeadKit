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

open class DefaultJsonNetworkService {
    public var session: Session

    public var serializationQueue: DispatchQueue
    public var callbackQueue: DispatchQueue

    public var jsonDecoder: JSONDecoder
    public var jsonEncoder: JSONEncoder

    public var plugins: [PluginType] = []

    public init(session: Session,
                jsonDecoder: JSONDecoder,
                jsonEncoder: JSONEncoder,
                serializationQueue: DispatchQueue = .global(qos: .default),
                callbackQueue: DispatchQueue = .main) {

        self.session = session
        self.serializationQueue = serializationQueue
        self.callbackQueue = callbackQueue
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    open func createProvider() -> MoyaProvider<SerializedRequest> {
        MoyaProvider<SerializedRequest>(callbackQueue: serializationQueue, session: session)
    }

    @available(iOS 13.0.0, *)
    public func process<B: Encodable, S: Decodable, F: Decodable>(request: EndpointRequest<B, S>,
                                                                  mapMoyaError: @escaping Closure<MoyaError, F>) async -> Result<S, F> {
        await process(request: request,
                      mapSuccess: Result.success,
                      mapFailure: Result.failure,
                      mapMoyaError: { .failure(mapMoyaError($0)) })
    }

    @available(iOS 13.0.0, *)
    public func process<B: Encodable, S: Decodable, F: Decodable, R>(request: EndpointRequest<B, S>,
                                                                     decodableSuccessStatusCodes: Set<Int>? = nil,
                                                                     decodableFailureStatusCodes: Set<Int>? = nil,
                                                                     mapSuccess: @escaping Closure<S, R>,
                                                                     mapFailure: @escaping Closure<F, R>,
                                                                     mapMoyaError: @escaping Closure<MoyaError, R>) async -> R {

        let cancellableBag = CancellableBag()

        return await withTaskCancellationHandler(handler: {
            cancellableBag.cancel()
        }, operation: {
            await withCheckedContinuation { continuation in
                process(request: request,
                        decodableSuccessStatusCodes: decodableSuccessStatusCodes,
                        decodableFailureStatusCodes: decodableFailureStatusCodes,
                        mapSuccess: mapSuccess,
                        mapFailure: mapFailure,
                        mapMoyaError: mapMoyaError) {

                    continuation.resume(returning: $0)
                }
                .add(to: cancellableBag)
            }
        })
    }

    public func process<B: Encodable, S: Decodable, F: Decodable, R>(request: EndpointRequest<B, S>,
                                                                     decodableSuccessStatusCodes: Set<Int>? = nil,
                                                                     decodableFailureStatusCodes: Set<Int>? = nil,
                                                                     mapSuccess: @escaping Closure<S, R>,
                                                                     mapFailure: @escaping Closure<F, R>,
                                                                     mapMoyaError: @escaping Closure<MoyaError, R>,
                                                                     completion: @escaping ParameterClosure<R>) -> Cancellable {

        ScopeCancellable { [jsonEncoder, serializationQueue, callbackQueue] scope in
            let workItem = DispatchWorkItem {
                guard !scope.isCancelled else {
                    return
                }

                do {
                    let serializedRequest = try request.serialize(using: ApplicationJsonBodySerializer(jsonEncoder: jsonEncoder))

                    scope.add(cancellable: self.process(request: serializedRequest,
                                                        decodableSuccessStatusCodes: decodableSuccessStatusCodes,
                                                        decodableFailureStatusCodes: decodableFailureStatusCodes,
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

    public func process<S: Decodable, F: Decodable, R>(request: SerializedRequest,
                                                       decodableSuccessStatusCodes: Set<Int>? = nil,
                                                       decodableFailureStatusCodes: Set<Int>? = nil,
                                                       mapSuccess: @escaping Closure<S, R>,
                                                       mapFailure: @escaping Closure<F, R>,
                                                       mapMoyaError: @escaping Closure<MoyaError, R>,
                                                       completion: @escaping ParameterClosure<R>) -> Cancellable {

        createProvider().request(request) { [jsonDecoder, callbackQueue] in
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

                switch decodeResult {
                case let .success(model):
                    result = model
                case let .failure(moyaError):
                    result = mapMoyaError(moyaError)
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
