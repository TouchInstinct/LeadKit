//
//  StaticCursor.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import RxSwift

/// Stub cursor implementation for array content type
public class StaticCursor<Element>: CursorType {

    public typealias LoadResultType = CountableRange<Int>

    private let content: [Element]

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
        return Observable.create { observer in
            if self.exhausted {
                observer.onError(CursorError.exhausted)

                return Disposables.create()
            }

            self.count = self.content.count

            self.exhausted = true

            observer.onNext(0..<self.count)

            return Disposables.create()
        }
    }
    
}
