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

/// Paging cursor implementation with enclosed cursor for fetching results
public class FixedPageCursor<Cursor: CursorType>: CursorType {

    fileprivate let cursor: Cursor

    fileprivate let pageSize: Int

    /// Initializer with enclosed cursor
    ///
    /// - Parameters:
    ///   - cursor: enclosed cursor
    ///   - pageSize: number of items loaded at once
    public init(cursor: Cursor, pageSize: Int) {
        self.cursor = cursor
        self.pageSize = pageSize
    }

    public var exhausted: Bool {
        return cursor.exhausted && cursor.count == count
    }

    public private(set) var count: Int = 0

    public subscript(index: Int) -> Cursor.Element {
        return cursor[index]
    }

    public func loadNextBatch() -> Observable<[Cursor.Element]> {
        return Observable.deferred {
            if self.exhausted {
                throw CursorError.exhausted
            }

            let restOfLoaded = self.cursor.count - self.count

            if restOfLoaded >= self.pageSize || self.cursor.exhausted {
                let startIndex = self.count
                self.count += min(restOfLoaded, self.pageSize)

                return .just(self.cursor[startIndex..<self.count])
            }

            return self.cursor.loadNextBatch()
                .flatMap { _ in
                    self.loadNextBatch()
            }
        }
    }

}

/// FixedPageCursor subclass with implementation of ResettableType
public class ResettableFixedPageCursor<Cursor: ResettableCursorType>: FixedPageCursor<Cursor>, ResettableType {

    public override init(cursor: Cursor, pageSize: Int) {
        super.init(cursor: cursor, pageSize: pageSize)
    }

    public required init(initialFrom other: ResettableFixedPageCursor) {
        super.init(cursor: other.cursor.reset(), pageSize: other.pageSize)
    }

}
