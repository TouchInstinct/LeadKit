//
//  Copyright (c) 2017 Touch Instinct
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

import RxSwift

/// Single load cursor configuration for single load operation
public final class SingleLoadCursorConfiguration<Element>: TotalCountCursorConfiguration {

    public typealias ResultType = [Element]

    private let loadingSingle: Single<ResultType>

    /// Initializer for Single with array result type.
    ///
    /// - Parameter loadingSingle: Single that will emit array of result type.
    public init(loadingSingle: Single<ResultType>) {
        self.loadingSingle = loadingSingle
    }

    public func resultSingle() -> Single<ResultType> {
        loadingSingle
    }

    public init(resetFrom other: SingleLoadCursorConfiguration) {
        self.loadingSingle = other.loadingSingle
    }
}

/// Cursor implementation for single load operation
@available(*, deprecated, message: "Use SingleLoadCursorConfiguration with TotalCountCursor.")
public class SingleLoadCursor<Element>: ResettableCursorType {

    private let loadingObservable: Single<[Element]>

    private var content: [Element] = []

    /// Initializer for array content type
    ///
    /// - Parameter loadingObservable: Single observable with element of [Element] type
    public init(loadingObservable: Single<[Element]>) {
        self.loadingObservable = loadingObservable
    }

    public required init(resetFrom other: SingleLoadCursor) {
        self.loadingObservable = other.loadingObservable
    }

    public private(set) var exhausted = false

    public var count: Int {
        content.count
    }

    public subscript(index: Int) -> Element {
        content[index]
    }

    public func loadNextBatch() -> Single<[Element]> {
        Single.deferred {
            if self.exhausted {
                return .error(CursorError.exhausted)
            }

            return self.loadingObservable.do(onSuccess: { [weak self] newItems in
                self?.onGot(result: newItems)
            })
        }
    }

    private func onGot(result: [Element]) {
        content = result
        exhausted = true
    }
}
