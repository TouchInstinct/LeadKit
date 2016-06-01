//
//  UIImage+RenderTemplate.swift
//  LeadKit
//
//  Created by Ivan Smolin on 01/06/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     method which render current template UIImage into new image using given color

     - parameter color:  color which used to fill template image
     - parameter opaque: a flag indicating whether the bitmap is opaque

     - returns: new UIImage rendered with given color
     */
    public func renderTemplateWithColor(color: UIColor, opaque: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0)

        let ctx = UIGraphicsGetCurrentContext()

        let imageRect = CGRect(origin: CGPoint.zero, size: size)

        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0

        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        CGContextSetRGBFillColor(ctx, r, g, b, a)

        CGContextTranslateCTM(ctx, 0, size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        CGContextClipToMask(ctx, imageRect, CGImage)
        CGContextFillRect(ctx, imageRect)

        CGContextSetBlendMode(ctx, .Multiply)
        CGContextDrawImage(ctx, imageRect, CGImage)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
