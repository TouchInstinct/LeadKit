//
//  UIViewAnimationCurve+AnimationOptions.swift
//  LeadKit
//
//  Created by Ivan Smolin on 12/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public extension UIViewAnimationCurve {

    /// UIViewAnimationOptions value matching current animation curve
    var animationOptions: UIViewAnimationOptions {
        switch self {
        case .easeInOut:
            return .curveEaseInOut
        case .easeIn:
            return .curveEaseIn
        case .easeOut:
            return .curveEaseOut
        case .linear:
            return .curveLinear
        }
    }
    
}
