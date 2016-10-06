//
//  CGImage+Creation.swift
//  LeadKit
//
//  Created by Ivan Smolin on 05/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import CoreGraphics

public extension CGImage {

    /**
     method which creates new CGImage instance filled by given color

     - parameter color:  color to fill
     - parameter width:  width of new image
     - parameter height: height of new image
     - parameter opaque: a flag indicating whether the bitmap is opaque (default: False)

     - returns: new instanse of UIImage with given size and color
     */
    public static func create(color: CGColor,
                              width: Int,
                              height: Int,
                              opaque: Bool = false) -> CGImage? {

        let context = CGContext.create(width: width,
                                       height: height,
                                       bitmapInfo: opaque ? opaqueBitmapInfo : alphaBitmapInfo)

        guard let ctx = context else {
            return nil
        }

        ctx.setFillColor(color)
        ctx.fill(CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height)))

        return ctx.makeImage()
    }

    /**
     creates an image from a UIView.

     - parameter fromView: The source view.

     - returns A new image
     */
    public static func create(fromView view: UIView) -> CGImage? {
        let size = view.bounds.size

        let ctxWidth = Int(ceil(size.width))
        let ctxHeight = Int(ceil(size.height))

        guard let ctx = CGContext.create(width: ctxWidth, height: ctxHeight) else {
            return nil
        }

        view.layer.render(in: ctx)
        
        return ctx.makeImage()
    }

}
