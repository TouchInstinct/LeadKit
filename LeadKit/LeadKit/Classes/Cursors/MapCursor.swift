//
//  MapCursor.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
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
