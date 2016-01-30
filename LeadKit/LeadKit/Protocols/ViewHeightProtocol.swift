//
//  ViewHeightProtocol.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

protocol ViewHeightProtocol {
    typealias ViewModelType
    
    static func viewHeight(forViewModel viewModel: ViewModelType) -> CGFloat
}