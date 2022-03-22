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

private final class ClosureObserverOperation<Output, Failure: Error>: AsyncOperation<Output, Failure> {
    private var dependencyObservation: NSKeyValueObservation?

    public init(dependency: AsyncOperation<Output, Failure>,
                onSuccess: ((Output) -> Void)? = nil,
                onFailure: ((Failure) -> Void)? = nil,
                callbackQueue: DispatchQueue = .main) {

        super.init()

        cancelOnCancellation(of: dependency)

        dependencyObservation = dependency.subscribe { [weak self] result in
            callbackQueue.async {
                onSuccess?(result)
            }

            self?.handle(result: result)
        } onFailure: { [weak self] error in
            callbackQueue.async {
                onFailure?(error)
            }

            self?.handle(error: error)
        }

        addDependency(dependency) // keeps strong reference to dependency as well

        state = .isReady
    }
}

public extension AsyncOperation {
    func observe(onSuccess: ((Output) -> Void)? = nil,
                 onFailure: ((Failure) -> Void)? = nil,
                 callbackQueue: DispatchQueue = .main) -> AsyncOperation<Output, Failure> {

        ClosureObserverOperation(dependency: self,
                                 onSuccess: onSuccess,
                                 onFailure: onFailure,
                                 callbackQueue: callbackQueue)
    }
}
