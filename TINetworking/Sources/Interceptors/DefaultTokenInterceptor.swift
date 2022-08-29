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

import Alamofire
import Foundation
import TIFoundationUtils

open class DefaultTokenInterceptor<RefreshError: Error>: RequestInterceptor {
    public typealias ShouldRefreshTokenClosure = (URLRequest?, HTTPURLResponse?, Error?) -> Bool
    public typealias RefreshTokenClosure = (@escaping (RefreshError?) -> Void) -> Cancellable

    public typealias RequestModificationClosure = (URLRequest) -> URLRequest

    let processingQueue = OperationQueue()

    let shouldRefreshToken: ShouldRefreshTokenClosure
    let refreshTokenClosure: RefreshTokenClosure

    public var defaultRetryStrategy: RetryResult = .doNotRetry
    public var requestModificationClosure: RequestModificationClosure?

    public init(shouldRefreshTokenClosure: @escaping ShouldRefreshTokenClosure,
                refreshTokenClosure: @escaping RefreshTokenClosure,
                requestModificationClosure: RequestModificationClosure? = nil) {

        self.shouldRefreshToken = shouldRefreshTokenClosure
        self.refreshTokenClosure = refreshTokenClosure
        self.requestModificationClosure = requestModificationClosure

        processingQueue.maxConcurrentOperationCount = 1
    }

    // MARK: - RequestAdapter

    open func adapt(_ urlRequest: URLRequest,
                    for session: Session,
                    completion: @escaping (Result<URLRequest, Error>) -> Void) {

        let adaptBag = BaseCancellableBag()

        let adaptCompletion: (Result<URLRequest, RefreshError>) -> Void = {
            adaptBag.cancellables.removeAll()
            completion($0.mapError { $0 as Error })
        }

        let modifiedRequest = requestModificationClosure?(urlRequest) ?? urlRequest

        validateAndRepair(validationClosure: { self.shouldRefreshToken(urlRequest, nil, nil) },
                          completion: adaptCompletion,
                          defaultCompletionResult: modifiedRequest,
                          recoveredCompletionResult: modifiedRequest)
            .add(to: adaptBag)
    }

    // MARK: - RequestRetrier
    
    open func retry(_ request: Request,
                    for session: Session,
                    dueTo error: Error,
                    completion: @escaping (RetryResult) -> Void) {

        let retryBag = BaseCancellableBag()

        let retryCompletion: (Result<RetryResult, RefreshError>) -> Void = {
            retryBag.cancellables.removeAll()
            switch $0 {
            case let .success(retryResult):
                completion(retryResult)
            case let .failure(refreshError):
                completion(.doNotRetryWithError(refreshError))
            }
        }

        validateAndRepair(validationClosure: { self.shouldRefreshToken(request.request, request.response, error) },
                          completion: retryCompletion,
                          defaultCompletionResult: defaultRetryStrategy,
                          recoveredCompletionResult: .retry)
            .add(to: retryBag)
    }

    open func validateAndRepair<T>(validationClosure: @escaping () -> Bool,
                                   completion: @escaping (Result<T, RefreshError>) -> Void,
                                   defaultCompletionResult: T,
                                   recoveredCompletionResult: T) -> Cancellable {

        let operation = ClosureAsyncOperation<T, RefreshError>(cancellableTaskClosure: { [refreshTokenClosure] operationCompletion in
            if validationClosure() {
                return refreshTokenClosure {
                    if let error = $0 {
                        operationCompletion(.failure(error))
                    } else {
                        operationCompletion(.success(recoveredCompletionResult))
                    }
                }
            } else {
                operationCompletion(.success(defaultCompletionResult))

                return Cancellables.nonCancellable()
            }
        })
        .observe(onResult: completion,
                 callbackQueue: .global())

        operation.add(to: processingQueue)

        return operation
    }
}
