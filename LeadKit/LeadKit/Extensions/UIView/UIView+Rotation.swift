//
//  UIView+Rotation.swift
//  LeadKit
//
//  Created by Alexey Gerasimov on 14/12/2016.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

extension UIView {

    private static let rotationKeyPath = "transform.rotation.z"

    /**
     Starts rotating the view around Z axis.

     - parameter duration:    Duration of one full 360 degrees rotation. One second is default.
     - parameter repeatCount: How many times the spin should be done. If not provided, the view will spin forever.
     - parameter clockwise:   Direction of the rotation. Default is clockwise (true).
     */
    public func startZRotation(duration: CFTimeInterval = 1, repeatCount: Float = Float.infinity, clockwise: Bool = true) {
        let animation = CABasicAnimation(keyPath: UIView.rotationKeyPath)
        let direction = clockwise ? 1.0 : -1.0
        animation.toValue = NSNumber(value: M_PI * 2 * direction)
        animation.duration = duration
        animation.isCumulative = true
        animation.repeatCount = repeatCount
        layer.add(animation, forKey: UIView.rotationKeyPath)
    }

    /// Stop rotating the view around Z axis.
    public func stopZRotation() {
        layer.removeAnimation(forKey: UIView.rotationKeyPath)
    }
    
}
