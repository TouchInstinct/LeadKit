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
    typealias IdentifierType
    
    /**
     method which returns reuse identifier with protocol associated type
     
     - returns: reuse identifier
     */
    static func reuseIdentifier() -> IdentifierType
}

/**
 *  protocol which ensures that specific type can return string reuse identifier for view
 */
public protocol ReuseIdentifierProtocol: AbstractReuseIdentifierProtocol {
    /**
     method which returns reuse identifier with string type
     
     - returns: reuse identifier
     */
    static func reuseIdentifier() -> String
}
