//
//  ViewModelBuilderProtocol.swift
//  LeadKit
//
//  Created by Иван Смолин on 10/02/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which declares required methods for view model builder
 */
protocol ViewModelBuilderProtocol {
    typealias ViewModelType
    
    /**
     method which returns new view model
     
     - returns: view model object
     */
    func buildViewModel() -> ViewModelType
}