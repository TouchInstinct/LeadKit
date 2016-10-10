//
//  NibNameProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can return nib name of view
 */
public protocol StaticNibNameProtocol {
    /**
     - returns: nib name string
     */
    static var nibName: String { get }
}
