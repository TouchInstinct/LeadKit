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

public final class ClosureAsyncOperation<Output, Failure: Error>: AsyncOperation<Output, Failure> {
    public typealias AsyncTaskClosure = () async -> Result<Output, Failure>
    public typealias CancellableTaskClosure = (@escaping (Result<Output, Failure>) -> Void) -> CancellableTask

    private let cancellableTaskClosure: CancellableTaskClosure
    private var cancellableTask: CancellableTask?

    public init(cancellableTaskClosure: @escaping CancellableTaskClosure) {
        self.cancellableTaskClosure = cancellableTaskClosure

        super.init()

        self.state = .isReady
    }

    @available(iOS 13.0, *)
    public convenience init(asyncTaskClosure: @escaping AsyncTaskClosure) {
        self.init { completion in
            Task {
                completion(await asyncTaskClosure())
            }
        }
    }

    public override func start() {
        super.start()

        cancellableTask = cancellableTaskClosure { [weak self] in
            switch $0 {
            case let .success(result):
                self?.handle(result: result)

            case let .failure(error):
                self?.handle(error: error)
            }
        }
    }

    public override func cancel() {
        super.cancel()

        cancellableTask?.cancel()
    }
}

public extension ClosureAsyncOperation {
    typealias NeverFailCancellableTaskClosure = (@escaping (Output) -> Void) -> CancellableTask

    convenience init(neverFailCancellableTaskClosure: @escaping NeverFailCancellableTaskClosure) where Failure == Never {
        self.init(cancellableTaskClosure: { completion in
            neverFailCancellableTaskClosure {
                completion(.success($0))
            }
        })
    }
}

@available(iOS 13.0, *)
public extension ClosureAsyncOperation {
    typealias NeverFailAsyncTaskClosure = () async -> Output

    convenience init(asyncTaskClosure: @escaping NeverFailAsyncTaskClosure) where Failure == Never {
        self.init {
            await .success(asyncTaskClosure())
        }
    }
}
