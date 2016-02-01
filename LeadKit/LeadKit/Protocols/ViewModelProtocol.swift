//
//  ViewModelProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can create view model and can apply new view state with view model
 */
public protocol AbstractViewModelProtocol {
    typealias ViewModelType
    typealias InputDataType
    

    /**
     method which applies new view state with view model object
     
     - parameter viewModel: view model to apply new view state
     
     - returns: nothing
     */
    func setViewModel(viewModel: ViewModelType)
    
    /**
     method which creates view model from input data
     
     - parameter inputData: input data (ex. api model)
     
     - returns: new view model object
     */
    static func createViewModel(fromInputData inputData: InputDataType) -> ViewModelType
}