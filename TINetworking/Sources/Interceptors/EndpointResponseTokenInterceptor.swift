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
import TIFoundationUtils

open class EndpointResponseTokenInterceptor<AE, NE>: DefaultTokenInterceptor<EndpointErrorResult<AE, NE>>, EndpointRequestRetrier {
    public typealias IsTokenInvalidErrorResultClosure = (EndpointErrorResult<AE, NE>) -> Bool
    public typealias RepairResult = Result<RetryResult, EndpointErrorResult<AE, NE>>

    private let isTokenInvalidErrorResultClosure: IsTokenInvalidErrorResultClosure

    public init(isTokenInvalidClosure: @escaping IsTokenInvalidClosure,
                refreshTokenClosure: @escaping RefreshTokenClosure,
                isTokenInvalidErrorResultClosure: @escaping IsTokenInvalidErrorResultClosure,
                requestModificationClosure: RequestModificationClosure? = nil) {

        self.isTokenInvalidErrorResultClosure = isTokenInvalidErrorResultClosure

        super.init(isTokenInvalidClosure: isTokenInvalidClosure,
                   refreshTokenClosure: refreshTokenClosure,
                   requestModificationClosure: requestModificationClosure)
    }

    // MARK: - EndpointRequestRetrier

    public func validateAndRepair(errorResults: [EndpointErrorResult<AE, NE>],
                                  completion: @escaping (RepairResult) -> Void) -> Cancellable {

        guard let firstErrorResult = errorResults.first else {
            completion(.success(.doNotRetry))

            return Cancellables.nonCancellable()
        }

        return validateAndRepair(validationClosure: { isTokenInvalidErrorResultClosure(firstErrorResult) },
                                 completion: completion,
                                 defaultCompletionResult: defaultRetryStrategy,
                                 recoveredCompletionResult: .retry)
    }
}
