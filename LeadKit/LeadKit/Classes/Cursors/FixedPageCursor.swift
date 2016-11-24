//
//  FixedPageCursor.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import RxSwift

/// Paging cursor implementation with enclosed cursor for fetching results
public class FixedPageCursor<Cursor: CursorType>: CursorType where Cursor.LoadResultType == CountableRange<Int> {

    public typealias LoadResultType = CountableRange<Int>

    private let cursor: Cursor

    private let pageSize: Int

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

    public func loadNextBatch() -> Observable<LoadResultType> {
        return Observable.deferred {
            if self.exhausted {
                throw CursorError.exhausted
            }

            let restOfLoaded = self.cursor.count - self.count

            if restOfLoaded >= self.pageSize || self.cursor.exhausted {
                let startIndex = self.count
                self.count += min(restOfLoaded, self.pageSize)

                return Observable.just(startIndex..<self.count)
            }

            return self.cursor.loadNextBatch()
                .flatMap { _ in self.loadNextBatch() }
        }
    }
    
}
