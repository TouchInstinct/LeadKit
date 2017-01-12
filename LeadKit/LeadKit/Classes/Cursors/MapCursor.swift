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

public typealias MapCursorLoadResultType = CountableRange<Int>

public extension CursorType where Self.LoadResultType == MapCursorLoadResultType {

    /// Creates MapCursor with current cursor
    ///
    /// - Parameter transform: closure to transform elements
    /// - Returns: new MapCursorInstance
    func flatMap<T>(transform: @escaping MapCursor<Self, T>.Transform) -> MapCursor<Self, T> {
        return MapCursor(cursor: self, transform: transform)
    }

}

/// Map cursor implementation with enclosed cursor for fetching results
public class MapCursor<Cursor: CursorType, T>: CursorType where Cursor.LoadResultType == MapCursorLoadResultType {

    public typealias LoadResultType = Cursor.LoadResultType

    public typealias Transform = (Cursor.Element) -> T?

    private let cursor: Cursor

    private let transform: Transform

    private var elements: [T] = []

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
        return cursor.exhausted
    }

    public var count: Int {
        return elements.count
    }

    public subscript(index: Int) -> T {
        return elements[index]
    }

    public func loadNextBatch() -> Observable<LoadResultType> {
        return cursor.loadNextBatch().map { loadedRange in
            let startIndex = self.elements.count
            self.elements += self.cursor[loadedRange].flatMap(self.transform)

            return startIndex..<self.elements.count
        }
    }
    
}
