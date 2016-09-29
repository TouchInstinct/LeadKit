//
//  UIImage+Alpha.swift
//  LeadKit
//
//  Created by Николай Ашанин on 28.09.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     - returns: true if the image has an alpha layer.
     */
    public func hasAlpha() -> Bool {
        let alpha = CGImageGetAlphaInfo(CGImage)
        switch alpha {
        case .First, .Last, .PremultipliedFirst, .PremultipliedLast:
            return true
        default:
            return false
        }
    }

    /**
     - returns: a copy of the given image, adding an alpha channel if it doesn't already have one.
     */
    public func applyAlpha() -> UIImage? {
        guard !hasAlpha() else {
            return self
        }

        let imageRef = CGImage
        let width = CGImageGetWidth(imageRef)
        let height = CGImageGetHeight(imageRef)
        let colorSpace = CGImageGetColorSpace(imageRef)

        // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.ByteOrderDefault.rawValue |
            CGImageAlphaInfo.PremultipliedFirst.rawValue)
        let offscreenContext = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, bitmapInfo.rawValue)

        // Draw the image into the context and retrieve the new image, which will now have an alpha layer
        CGContextDrawImage(offscreenContext,
                           CGRect(x: 0, y: 0, width: width, height: height),
                           imageRef)
        guard let cgImage = CGBitmapContextCreateImage(offscreenContext) else {
            return nil
        }
        let imageWithAlpha = UIImage(CGImage: cgImage)
        return imageWithAlpha
    }

    /**
     returns a copy of the image with a transparent border of the given size added around its edges.
     i.e. For rotating an image without getting jagged edges.

     - parameter padding: The padding amount.

     - returns: A new image.
     */
    public func applyPadding(padding: CGFloat) -> UIImage? {
        // If the image does not have an alpha layer, add one
        guard let image = applyAlpha() else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: size.width + padding * 2, height: size.height + padding * 2)

        // Build a context that's the same dimensions as the new size
        let colorSpace = CGImageGetColorSpace(CGImage)
        let bitmapInfo = CGImageGetBitmapInfo(CGImage)
        let bitsPerComponent = CGImageGetBitsPerComponent(CGImage)
        let context = CGBitmapContextCreate(nil,
                                            Int(rect.size.width),
                                            Int(rect.size.height),
                                            bitsPerComponent, 0, colorSpace,
                                            bitmapInfo.rawValue)

        // Draw the image in the center of the context, leaving a gap around the edges
        let imageLocation = CGRect(x: padding, y: padding, width: image.size.width, height: image.size.height)
        CGContextDrawImage(context, imageLocation, CGImage)

        // Create a mask to make the border transparent, and combine it with the image
        let imageWithPadding = imageRefWithPadding(padding, size: rect.size)
        guard let cgImage = CGImageCreateWithMask(CGBitmapContextCreateImage(context), imageWithPadding) else {
            return nil
        }
        let transparentImage = UIImage(CGImage: cgImage)
        return transparentImage
    }

    /**
     creates a mask that makes the outer edges transparent and everything else opaque. 
     The size must include the entire mask (opaque part + transparent border).

     - parameter padding: The padding amount.
     - parameter size: The size of the image.

     - returns: A Core Graphics Image Ref
     */
    private func imageRefWithPadding(padding: CGFloat,
                                     size: CGSize) -> CGImageRef? {
        // Build a context that's the same dimensions as the new size
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.ByteOrderDefault.rawValue | CGImageAlphaInfo.None.rawValue)
        let context = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), 8, 0, colorSpace, bitmapInfo.rawValue)
        // Start with a mask that's entirely transparent
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextFillRect(context, CGRect(x: 0, y: 0, width: size.width, height: size.height))
        // Make the inner part (within the border) opaque
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        let fillRect = CGRect(x: padding,
                              y: padding,
                              width: size.width - padding * 2,
                              height: size.height - padding * 2)
        CGContextFillRect(context, fillRect)
        // Get an image of the context
        let maskImageRef = CGBitmapContextCreateImage(context)
        return maskImageRef
    }

}
