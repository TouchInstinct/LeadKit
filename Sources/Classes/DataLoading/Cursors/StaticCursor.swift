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
public class StaticCursor<Element>: ResettableRxDataSourceCursor {

    public typealias ResultType = [Element]

    private let content: [Element]

    /// Initializer for array content type
    ///
    /// - Parameter content: array with elements of Element type
    public init(content: [Element]) {
        self.content = content
    }

    public required init(resetFrom other: StaticCursor) {
        self.content = other.content
    }

    public private(set) var exhausted = false

    public private(set) var count = 0

    public subscript(index: Int) -> Element {
        content[index]
    }

    public func loadNextBatch() -> Single<[Element]> {
        Single.deferred {
            if self.exhausted {
                return .error(CursorError.exhausted)
            }

            self.count = self.content.count

            self.exhausted = true

            return .just(self.content)
        }
    }
}
