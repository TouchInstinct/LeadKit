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

import TIFoundationUtils
import TINetworking

open class RequestExecutor<S: Decodable, AE: Decodable, NE>: Cancellable {
    public typealias ExecutionCompletion = (EndpointRecoverableRequestResult<S, AE, NE>) -> Void
    public typealias ExecutionClosure = (@escaping ExecutionCompletion) -> Cancellable
    public typealias SuccessCompletion = (S) -> Void
    public typealias FailureCompletion = (ErrorCollection<EndpointErrorResult<AE, NE>>) -> Void

    private let executionClosure: ExecutionClosure
    private var executingRequest: Cancellable?
    private var attemptsLeft: Int
    
    public var successCompletion: SuccessCompletion
    public var failureCompletion: FailureCompletion?

    public init(executionClosure: @escaping ExecutionClosure,
                successCompletion: @escaping SuccessCompletion,
                failureCompletion: FailureCompletion? = nil,
                numberOfAttempts: Int = 3) {
        
        self.executionClosure = executionClosure
        self.successCompletion = successCompletion
        self.failureCompletion = failureCompletion
        self.attemptsLeft = numberOfAttempts
    }

    open func execute() {
        cancel()

        executingRequest = executionClosure { [weak self] in
            switch $0 {
            case let .success(result):
                self?.handle(successResult: result)
            case let .failure(errorCollection):
                self?.handle(failure: errorCollection)
            }
        }
    }

    open func handle(successResult: S) {
        successCompletion(successResult)
    }

    open func handle(failure: ErrorCollection<EndpointErrorResult<AE, NE>>) {
        if shouldRetry(failure: failure) && attemptsLeft > 0 {
            attemptsLeft -= 1
            execute()
        } else {
            failureCompletion?(failure)
        }
    }

    open func shouldRetry(failure: ErrorCollection<EndpointErrorResult<AE, NE>>) -> Bool {
        if case .networkError = failure.failures.first {
            return true
        }

        return false
    }

    open func cancel() {
        executingRequest?.cancel()
    }
}
