//
//  CursorType.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import RxSwift

/// Protocol which describes Cursor data type
public protocol CursorType {

    associatedtype Element

    associatedtype LoadResultType

    /// Indicates that cursor load all available results
    var exhausted: Bool { get }

    /// Current number of items in cursor
    var count: Int { get }

    subscript(index: Int) -> Self.Element { get }

    /// Loads next batch of results
    ///
    /// - Returns: Observable of LoadResultType
    func loadNextBatch() -> Observable<LoadResultType>
    
}
