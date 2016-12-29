//
//  StaticViewHeightProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can return height of view
 */
public protocol StaticViewHeightProtocol {
    /**
     method which returns view height
     
     - returns: view height
     */
    static var viewHeight: CGFloat { get }
}
