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

import Foundation

private final class ClosureObserverOperation<Output, Failure: Error>: DependendAsyncOperation<Output, Failure> {
    public typealias OnResultClosure = (Result<Output, Failure>) -> Void

    private let onResult: OnResultClosure?
    private let callbackQueue: DispatchQueue

    public init(dependency: AsyncOperation<Output, Failure>,
                onResult: OnResultClosure? = nil,
                callbackQueue: DispatchQueue = .main) {

        self.onResult = onResult
        self.callbackQueue = callbackQueue

        super.init(dependency: dependency) { $0 }
    }

    override func handle(result: Result<Output, Failure>) {
        self.result = result

        callbackQueue.async {
            self.onResult?(result)
            self.state = .isFinished
        }
    }
}

public extension AsyncOperation {
    func observe(onResult: ((Result<Output, Failure>) -> Void)? = nil,
                 callbackQueue: DispatchQueue = .main) -> AsyncOperation<Output, Failure> {

        ClosureObserverOperation(dependency: self,
                                 onResult: onResult,
                                 callbackQueue: callbackQueue)
    }

    func observe(onSuccess: ((Output) -> Void)? = nil,
                 onFailure: ((Failure) -> Void)? = nil,
                 callbackQueue: DispatchQueue = .main) -> AsyncOperation<Output, Failure> {

        let onResult: ClosureObserverOperation<Output, Failure>.OnResultClosure = {
            switch $0 {
            case let .success(output):
                onSuccess?(output)

            case let .failure(error):
                onFailure?(error)
            }
        }

        return observe(onResult: onResult, callbackQueue: callbackQueue)
    }
}
