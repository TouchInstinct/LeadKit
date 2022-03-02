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

    public func process<RF: RequestFactory>(recoverableRequest: RF,
                                            prependErrorHandlers: [ErrorHandler] = [],
                                            appendErrorHandlers: [ErrorHandler] = [],
                                            mapMoyaError: @escaping Closure<MoyaError, ApiError>) async -> Result<RF.SuccessResponse, ApiError> where RF.Body: Encodable, RF.SuccessResponse: Decodable, RF.CreateFailure == ApiError {

        await process(recoverableRequest: recoverableRequest,
                      errorHandlers: prependErrorHandlers + defaultErrorHandlers + appendErrorHandlers,
                      mapMoyaError: mapMoyaError)
    }

    public func process<RF: RequestFactory>(recoverableRequest: RF,
                                            errorHandlers: [ErrorHandler] = [],
                                            mapMoyaError: @escaping Closure<MoyaError, ApiError>) async -> Result<RF.SuccessResponse, ApiError> where RF.Body: Encodable, RF.SuccessResponse: Decodable, RF.CreateFailure == ApiError {

        switch recoverableRequest.create() {
        case let .success(endpointRequest):
            let result = await process(request: endpointRequest, mapMoyaError: mapMoyaError) as Result<RF.SuccessResponse, ApiError>

            switch result {
            case let .failure(errorResponse):
                let chain = AsyncEventHandlingChain(handlers: errorHandlers)

                if await chain.handle(errorResponse) {
                    return await process(recoverableRequest: recoverableRequest,
                                         errorHandlers: errorHandlers,
                                         mapMoyaError: mapMoyaError)
                } else {
                    return result
                }
            default:
                return result
            }
        case let .failure(error):
            return .failure(error)
        }
    }

    public func register<ErrorHandler: AsyncErrorHandler>(defaultErrorHandler: ErrorHandler) where ErrorHandler.EventType == ApiError {
        defaultErrorHandlers.append(defaultErrorHandler.asAnyAsyncEventHandler())
    }

    public func set<ErrorHandler: AsyncErrorHandler>(defaultErrorHandlers: ErrorHandler...) where ErrorHandler.EventType == ApiError {
        self.defaultErrorHandlers = defaultErrorHandlers.map { $0.asAnyAsyncEventHandler() }
    }
}
