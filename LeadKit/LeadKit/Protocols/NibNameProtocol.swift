//
//  NIbNameProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can return nib name of view for specific configuration
 */
public protocol AbstractNibNameProtocol {
    associatedtype ConfigurationType

    /**
     static method which returns nib name for specific configuration
     
     - parameter configuration: object which represents configuration
     
     - returns: nib name string
     */
    static func nibName(forConfiguration configuration: ConfigurationType) -> String
}

/**
 *  protocol which ensures that specific type can return nib name of view
 for specified UserInterfaceIdiom (iPhone, iPad, AppleTV)
 */

public protocol NibNameProtocol: AbstractNibNameProtocol {
    /**
     static method which returns nib name for specific UIUserInterfaceIdiom value
     
     - parameter configuration: object which represents configuration in terms of user interface idiom
     
     - returns: nib name string
     */
    static func nibName(forConfiguration configuration: UIUserInterfaceIdiom) -> String
}
