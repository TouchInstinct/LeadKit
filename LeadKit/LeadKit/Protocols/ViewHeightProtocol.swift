//
//  ViewHeightProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can return height of view for view model
 */
public protocol ViewHeightProtocol {
    associatedtype ViewModelType
    
    /**
     method which returns view height for specific view model
     
     - parameter viewModel: object which represents view model of view
     
     - returns: view height
     */
    static func viewHeight(forViewModel viewModel: ViewModelType) -> CGFloat
}
