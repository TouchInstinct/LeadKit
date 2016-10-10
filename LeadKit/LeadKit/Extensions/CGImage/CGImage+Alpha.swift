//
//  CGImage+Alpha.swift
//  LeadKit
//
//  Created by Ivan Smolin on 04/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import CoreGraphics

public extension CGImage {

    /**
     - returns: true if the image has an alpha layer.
     */
    public var hasAlpha: Bool {
        switch alphaInfo {
        case .first, .last, .premultipliedFirst, .premultipliedLast:
            return true
        default:
            return false
        }
    }

    /**
     - returns: a copy of the given image, adding an alpha channel if it doesn't already have one.
     */
    public func applyAlpha() -> CGImage? {
        guard !hasAlpha else {
            return self
        }

        let ctx = CGContext.create(width: width, height: height, bitmapInfo: alphaBitmapInfo)
        ctx?.draw(self, in: bounds)

        return ctx?.makeImage()
    }
    
}
