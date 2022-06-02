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
    public typealias ErrorType = EndpointErrorResult<ApiError, MoyaError>
    public typealias ErrorHandlerResultType = RecoverableErrorHandlerResult<ErrorType>
    public typealias ErrorHandlerType = AnyAsyncEventHandler<ErrorType, ErrorHandlerResultType>

    public private(set) var defaultErrorHandlers: [ErrorHandlerType] = []

    open func process<B: Encodable, S>(recoverableRequest: EndpointRequest<B, S>,
                                       prependErrorHandlers: [ErrorHandlerType] = [],
                                       appendErrorHandlers: [ErrorHandlerType] = []) async ->
    RequestResult<S, ApiError> {

        await process(recoverableRequest: recoverableRequest,
                      errorHandlers: prependErrorHandlers + defaultErrorHandlers + appendErrorHandlers)
    }

    open func process<B: Encodable, S>(recoverableRequest: EndpointRequest<B, S>,
                                       errorHandlers: [ErrorHandlerType]) async -> RequestResult<S, ApiError> {

        let result: RequestResult<S, ApiError> = await process(request: recoverableRequest)

        if case let .failure(errorResponse) = result {
            for handler in errorHandlers {
                let handlerResult = await handler.handle(errorResponse)

                switch handlerResult {
                case let .forwardError(error):
                    return .failure(error)

                case .recoverRequest:
                    return await process(recoverableRequest: recoverableRequest, errorHandlers: errorHandlers)

                case .skipError:
                    break
                }
            }
        }

        return result
    }

    public func register<ErrorHandler: AsyncErrorHandler>(defaultErrorHandler: ErrorHandler)
        where ErrorHandler.EventType == ErrorHandlerType.EventType, ErrorHandler.ResultType == ErrorHandlerType.ResultType {

        defaultErrorHandlers.append(defaultErrorHandler.asAnyAsyncEventHandler())
    }

    public func set<ErrorHandler: AsyncErrorHandler>(defaultErrorHandlers: ErrorHandler...)
        where ErrorHandler.EventType == ErrorHandlerType.EventType, ErrorHandler.ResultType == ErrorHandlerType.ResultType {

        self.defaultErrorHandlers = defaultErrorHandlers.map { $0.asAnyAsyncEventHandler() }
    }
}
