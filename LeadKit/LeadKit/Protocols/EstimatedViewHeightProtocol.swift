//
//  EstimatedViewheightProtocol.swift
//  LeadKit
//
//  Created by Иван Смолин on 12/04/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can return estimated height of view for view model
 */
public protocol EstimatedViewHeightProtocol {
    associatedtype ViewModelType
    
    /**
     method which returns estimated view height for specific view model
     
     - parameter viewModel: object which represents view model of view
     
     - returns: estimatedViewHeight view height
     */
    static func estimatedViewHeight(forViewModel viewModel: ViewModelType) -> CGFloat
}