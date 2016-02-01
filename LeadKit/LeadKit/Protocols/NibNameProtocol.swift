//
//  NIbNameProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public protocol AbstractNibNameProtocol {
    typealias ConfigurationType
    
    static func nibName(forConfiguration configuration: ConfigurationType) -> String
}

public protocol NibNameProtocol : AbstractNibNameProtocol {
    static func nibName(forConfiguration configuration: UIUserInterfaceIdiom) -> String
}