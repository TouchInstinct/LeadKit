//
//  ReuseIdentifierProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 24/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can return reuse identifier for view
 */
public protocol AbstractReuseIdentifierProtocol {
    associatedtype IdentifierType
    
    /**
     - returns: reuse identifier with protocol associated type
     */
    static var reuseIdentifier: IdentifierType { get }
}

/**
 *  protocol which ensures that specific type can return string reuse identifier for view
 */
public protocol ReuseIdentifierProtocol: AbstractReuseIdentifierProtocol {
    /**
     - returns: reuse identifier with string type
     */
    static var reuseIdentifier: String { get }
}
