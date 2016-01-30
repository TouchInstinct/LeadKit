//
//  ReuseIdentifierProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 24/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public protocol AbstractReuseIdentifierProtocol {
    typealias IdentifierType
    
    static func reuseIdentifier() -> IdentifierType
}

public protocol ReuseIdentifierProtocol: AbstractReuseIdentifierProtocol {
    static func reuseIdentifier() -> String
}