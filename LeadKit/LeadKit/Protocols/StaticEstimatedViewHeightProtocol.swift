//
//  StaticEstimatedViewheightProtocol.swift
//  LeadKit
//
//  Created by Иван Смолин on 31/03/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can return estimated height of view
 */
public protocol StaticEstimatedViewHeightProtocol {
    /**
     method which return estimated view height
     
     - returns: estimated view height
     */
    static func estimatedViewHeight() -> CGFloat
}
