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

open class AsyncOperation<Output, Failure: Error>: Operation {

    open var result: Result<Output, Failure>?

    var state: State? = nil { // isReady == false
        // KVO support
        willSet {
            willChangeValue(forKey: newValue.orReady.rawValue)
            willChangeValue(forKey: state.orReady.rawValue)
        }

        didSet {
            didChangeValue(forKey: state.orReady.rawValue)
            didChangeValue(forKey: oldValue.orReady.rawValue)
        }
    }

    // MARK: - Operation override

    open override var isCancelled: Bool {
        state == .isCancelled
    }

    open override var isExecuting: Bool {
        state == .isExecuting
    }

    open override var isFinished: Bool {
        state == .isFinished
    }

    open override var isReady: Bool {
        state == .isReady
    }

    open override var isAsynchronous: Bool {
        true
    }

    open override func start() {
        state = .isExecuting

        if result != nil {
            state = .isFinished
        }
    }

    open override func cancel() {
        state = .isCancelled
    }

    // MARK: - Methods for subclass override

    open func handle(result: Output) {
        self.result = .success(result)

        state = .isFinished
    }

    open func handle(error: Failure) {
        self.result = .failure(error)

        state = .isFinished
    }

    // MARK: - Completion observation

    public func subscribe(onSuccess: ((Output) -> Void)? = nil,
                          onFailure: ((Failure) -> Void)? = nil) -> NSKeyValueObservation {

        observe(\.isFinished, options: [.new]) { object, change in
            if let isFinished = change.newValue, isFinished {
                switch object.result {
                case let .success(result)?:
                    onSuccess?(result)

                case let .failure(failure)?:
                    onFailure?(failure)

                default:
                    assertionFailure("Got nil result from operation when isFinished was true!")
                }
            }
        }
    }
}

private extension Optional where Wrapped == Operation.State {
    var orReady: Wrapped {
        self ?? .isReady
    }
}
