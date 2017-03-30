//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import RxSwift

/// Stub cursor implementation for array content type
public class StaticCursor<Element>: CursorType {

    public typealias LoadResultType = CountableRange<Int>

    private let content: [Element]

    private let semaphore = DispatchSemaphore(value: 1)

    /// Initializer for array content type
    ///
    /// - Parameter content: array with elements of Elemet type
    public init(content: [Element]) {
        self.content = content
    }

    public private(set) var exhausted = false

    public private(set) var count = 0

    public subscript(index: Int) -> Element {
        return content[index]
    }

    public func loadNextBatch() -> Observable<LoadResultType> {
        return Observable.deferred {
            self.semaphore.wait()

            if self.exhausted {
                throw CursorError.exhausted
            }

            self.count = self.content.count

            self.exhausted = true

            return Observable.just(0..<self.count)
        }
        .do(onNext: { [weak semaphore] _ in
            semaphore?.signal()
        }, onError: { [weak semaphore] _ in
            semaphore?.signal()
        })
    }

}
