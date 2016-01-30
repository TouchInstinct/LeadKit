//
//  ViewModelProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public protocol AbstractViewModelProtocol {
    typealias ViewModelType
    typealias InputDataType
    
    func setViewModel(viewModel: ViewModelType)
    
    static func createViewModel(fromInputData inputData: InputDataType) -> ViewModelType
}