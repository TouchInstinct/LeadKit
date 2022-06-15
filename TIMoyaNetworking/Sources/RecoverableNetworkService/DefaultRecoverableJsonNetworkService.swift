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

import Moya
import TINetworking
import TISwiftUtils

@available(iOS 13.0.0, *)
open class DefaultRecoverableJsonNetworkService<ApiError: Decodable & Error>: DefaultJsonNetworkService {
    public typealias EndpointResponse<S: Decodable> = EndpointRecoverableRequestResult<S, ApiError, MoyaError>
    public typealias ErrorType = EndpointErrorResult<ApiError, MoyaError>
    public typealias RequestRetrier = AnyEndpointRequestRetrier<ErrorType>

    public private(set) var defaultRequestRetriers: [RequestRetrier] = []

    open func process<B: Encodable, S>(recoverableRequest: EndpointRequest<B, S>,
                                       prependRequestRetriers: [RequestRetrier] = [],
                                       appendRequestRetriers: [RequestRetrier] = []) async ->
    EndpointResponse<S> {

        await process(recoverableRequest: recoverableRequest,
                      errorHandlers: prependRequestRetriers + defaultRequestRetriers + appendRequestRetriers)
    }

    open func process<B: Encodable, S>(recoverableRequest: EndpointRequest<B, S>,
                                       errorHandlers: [RequestRetrier]) async -> EndpointResponse<S> {

        let result: RequestResult<S, ApiError> = await process(request: recoverableRequest)

        if case let .failure(errorResponse) = result {
            var failures = [errorResponse]

            for handler in errorHandlers {
                let handlerResult = await handler.validateAndRepair(errorResults: failures)

                switch handlerResult {
                case let .success(retryResult):
                    switch retryResult {
                    case .retry, .retryWithDelay:
                        return await process(recoverableRequest: recoverableRequest, errorHandlers: errorHandlers)
                    case .doNotRetry, .doNotRetryWithError:
                        break
                    }
                case let .failure(error):
                    failures.append(error)
                }
            }

            return .failure(.init(failures: failures))
        }

        return result.mapError { .init(failures: [$0]) }
    }

    public func register<RequestRetrier: EndpointRequestRetrier>(defaultRequestRetrier: RequestRetrier)
        where RequestRetrier.ErrorResult == ErrorType {

        defaultRequestRetriers.append(defaultRequestRetrier.asAnyEndpointRequestRetrier())
    }

    public func set<RequestRetrier: EndpointRequestRetrier>(defaultRequestRetriers: RequestRetrier...)
        where RequestRetrier.ErrorResult == ErrorType {

        self.defaultRequestRetriers = defaultRequestRetriers.map { $0.asAnyEndpointRequestRetrier() }
    }
}
