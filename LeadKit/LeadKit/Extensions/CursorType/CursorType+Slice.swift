//
//  CursorType+Slice.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public extension CursorType where LoadResultType == CountableRange<Int> {

    subscript(range: LoadResultType) -> [Self.Element] {
        return range.map { self[$0] }
    }

    var loadedElements: [Self.Element] {
        return self[0..<count]
    }
    
}

public extension CursorType where LoadResultType == CountableClosedRange<Int> {

    subscript(range: LoadResultType) -> [Self.Element] {
        return range.map { self[$0] }
    }

    var loadedElements: [Self.Element] {
        return self[0...count - 1]
    }
    
}
