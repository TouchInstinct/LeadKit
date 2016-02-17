//
//  StoryboardIdentifierProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 24/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can return storyboard identifier of view controller
 */
public protocol StoryboardIdentifierProtocol {
    /**
     method which returns storyboard identifier of view controller
     
     - returns: storyboard identifier string
     */
    static func storyboardIdentifier() -> String
}
