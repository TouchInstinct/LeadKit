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

public extension CursorType {

    /// Creates MapCursor with current cursor
    ///
    /// - Parameter transform: closure to transform elements
    /// - Returns: new MapCursor instance
    func flatMap<T>(transform: @escaping MapCursor<Self, T>.Transform) -> MapCursor<Self, T> {
        return MapCursor(cursor: self, transform: transform)
    }

    /// Creates ResettableMapCursor with current cursor
    ///
    /// - Parameter transform: closure to transform elements
    /// - Returns: new ResettableMapCursor instance
    func flatMap<T>(transform: @escaping ResettableMapCursor<Self, T>.Transform)
        -> ResettableMapCursor<Self, T> where Self: ResettableCursorType {

        return ResettableMapCursor(cursor: self, transform: transform)
    }

}

/// Map cursor implementation with enclosed cursor for fetching results
public class MapCursor<Cursor: CursorType, T>: CursorType {

    public typealias Transform = (Cursor.Element) -> T?

    fileprivate let cursor: Cursor

    fileprivate let transform: Transform

    private var elements: [T] = []

    private let mutex = Mutex()

    /// Initializer with enclosed cursor
    ///
    /// - Parameters:
    ///   - cursor: enclosed cursor
    ///   - transform: closure to transform elements
    public init(cursor: Cursor, transform: @escaping Transform) {
        self.cursor = cursor
        self.transform = transform
    }

    public var exhausted: Bool {
        return mutex.sync { cursor.exhausted }
    }

    public var count: Int {
        return mutex.sync { elements.count }
    }

    public subscript(index: Int) -> T {
        return mutex.sync { elements[index] }
    }

    public func loadNextBatch() -> Observable<[T]> {
        return Observable.deferred {
            self.mutex.unbalancedLock()

            return self.cursor.loadNextBatch().map { newItems in
                let transformedNewItems = newItems.flatMap(self.transform)
                self.elements += transformedNewItems

                return transformedNewItems
            }
        }
        .do(onNext: { _ in
            self.mutex.unbalancedUnlock()
        }, onError: { _ in
            self.mutex.unbalancedUnlock()
        })
    }

}

/// MapCursor subclass with implementation of ResettableType
public class ResettableMapCursor<Cursor: ResettableCursorType, T>: MapCursor<Cursor, T>, ResettableType {

    public override init(cursor: Cursor, transform: @escaping Transform) {
        super.init(cursor: cursor, transform: transform)
    }

    public required init(initialFrom other: ResettableMapCursor) {
        super.init(cursor: other.cursor, transform: other.transform)
    }

}
