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
import TISwiftUtils
import Moya

@available(iOS 13.0.0, *)
open class DefaultRecoverableJsonNetworkService<ApiError: Decodable & Error>: DefaultJsonNetworkService {
    public typealias ErrorHandler = AnyAsyncEventHandler<ApiError>

    private var defaultErrorHandlers: [ErrorHandler] = []

    public func process<B: Encodable, S: Decodable>(request: EndpointRequest<B, S>,
                                                    prependErrorHandlers: [ErrorHandler] = [],
                                                    appendErrorHandlers: [ErrorHandler] = [],
                                                    mapMoyaError: @escaping Closure<MoyaError, ApiError>) async -> Result<S, ApiError> {

        await process(request: request,
                      errorHandlers: prependErrorHandlers + defaultErrorHandlers + appendErrorHandlers,
                      mapMoyaError: mapMoyaError)
    }

    public func process<B: Encodable, S: Decodable>(request: EndpointRequest<B, S>,
                                                    errorHandlers: [ErrorHandler] = [],
                                                    mapMoyaError: @escaping Closure<MoyaError, ApiError>) async -> Result<S, ApiError> {

        let result = await process(request: request, mapMoyaError: mapMoyaError)

        if case let .failure(errorResponse) = result {
            let chain = AsyncEventHandlingChain(handlers: errorHandlers)

            if await chain.handle(errorResponse) {
                return await process(request: request,
                                     errorHandlers: errorHandlers,
                                     mapMoyaError: mapMoyaError)
            }
        }

        return result
    }

    public func register<ErrorHandler: AsyncErrorHandler>(defaultErrorHandler: ErrorHandler) where ErrorHandler.EventType == ApiError {
        defaultErrorHandlers.append(defaultErrorHandler.asAnyAsyncEventHandler())
    }

    public func set<ErrorHandler: AsyncErrorHandler>(defaultErrorHandlers: ErrorHandler...) where ErrorHandler.EventType == ApiError {
        self.defaultErrorHandlers = defaultErrorHandlers.map { $0.asAnyAsyncEventHandler() }
    }
}
