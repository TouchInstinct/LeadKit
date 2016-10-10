//
//  CGImage+Template.swift
//  LeadKit
//
//  Created by Ivan Smolin on 05/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import CoreGraphics

public extension CGImage {

    /**
     method which render current template CGImage into new image using given color

     - parameter withColor: color which used to fill template image

     - returns: new CGImage rendered with given color or nil if something goes wrong
     */
    public func renderTemplate(withColor color: CGColor) -> CGImage? {
        guard let ctx = CGContext.create(forCGImage: self) ?? CGContext.create(width: width, height: height) else {
            return nil
        }

        let imageRect = bounds

        ctx.setFillColor(color)

        ctx.translateBy(x: 0, y: CGFloat(height))
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.clip(to: imageRect, mask: self)
        ctx.fill(imageRect)

        ctx.setBlendMode(.multiply)

        return ctx.makeImage()
    }
    
}
