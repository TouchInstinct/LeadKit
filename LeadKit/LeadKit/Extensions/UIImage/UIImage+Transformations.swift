//
//  UIImage+Transformations.swift
//  LeadKit
//
//  Created by Ivan Smolin on 07/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     method which creates new UIImage from current with rounded corners

     - parameter radius: corners radius
     - parameter opaque: a flag indicating whether the bitmap is opaque (default: False)

     - returns: new UIImage instance rendered with given radius
     */
    public func roundedImage(withRadius radius: CGFloat, opaque: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)

        defer { UIGraphicsEndImageContext() }

        let imageRect = CGRect(origin: CGPoint.zero, size: size)

        UIBezierPath(roundedRect: imageRect, cornerRadius: radius).addClip()

        drawInRect(imageRect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /**
     creates a new image with rounded corners.

     - parameter cornerRadius: The corner radius.

     - returns: A new image
     */
    public func roundCorners(cornerRadius: CGFloat) -> UIImage? {
        guard let imageWithAlpha = applyAlpha() else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let width = CGImageGetWidth(imageWithAlpha?.CGImage)
        let height = CGImageGetHeight(imageWithAlpha?.CGImage)
        let bits = CGImageGetBitsPerComponent(imageWithAlpha?.CGImage)
        let colorSpace = CGImageGetColorSpace(imageWithAlpha?.CGImage)
        let bitmapInfo = CGImageGetBitmapInfo(imageWithAlpha?.CGImage)
        let context = CGBitmapContextCreate(nil, width, height, bits, 0, colorSpace, bitmapInfo.rawValue)
        let rect = CGRect(x: 0, y: 0, width: CGFloat(width) * scale, height: CGFloat(height) * scale)
        CGContextBeginPath(context)
        if cornerRadius == 0 {
            CGContextAddRect(context, rect)
        } else {
            CGContextSaveGState(context)
            CGContextTranslateCTM(context, rect.minX, rect.minY)
            CGContextScaleCTM(context, cornerRadius, cornerRadius)
            let roundedWidth = rect.size.width / cornerRadius
            let roundedHeight = rect.size.height / cornerRadius
            CGContextMoveToPoint(context, roundedWidth, roundedHeight/2)
            CGContextAddArcToPoint(context, roundedWidth, roundedHeight, roundedWidth/2, roundedHeight, 1)
            CGContextAddArcToPoint(context, 0, roundedHeight, 0, roundedHeight/2, 1)
            CGContextAddArcToPoint(context, 0, 0, roundedWidth/2, 0, 1)
            CGContextAddArcToPoint(context, roundedWidth, 0, roundedWidth, roundedHeight/2, 1)
            CGContextRestoreGState(context)
        }
        CGContextClosePath(context)
        CGContextClip(context)
        CGContextDrawImage(context, rect, imageWithAlpha?.CGImage)
        guard let bitmapImage = CGBitmapContextCreateImage(context) else {
            return nil
        }
        let image = UIImage(CGImage: bitmapImage,
                            scale: scale,
                            orientation: .Up)
        UIGraphicsEndImageContext()
        return image
    }

    /**
     creates a new image with rounded corners and border.

     - parameter cornerRadius: The corner radius.
     - parameter border: The size of the border.
     - parameter color: The color of the border.

     - returns: A new image
     */
    public func roundCorners(cornerRadius: CGFloat,
                             border: CGFloat,
                             color: UIColor) -> UIImage? {
        return roundCorners(cornerRadius)?.applyBorder(border, color: color)
    }

    /**
     creates a new circle image.

     - returns: A new image
     */
    public func roundCornersToCircle() -> UIImage? {
        let shortest = min(size.width, size.height)
        return cropToSquare()?.roundCorners(shortest/2)
    }

    /**
     creates a new circle image with a border.

     - parameter border: CGFloat The size of the border.
     - parameter color: UIColor The color of the border.

     - returns: UIImage?
     */
    public func roundCornersToCircle(border border: CGFloat, color: UIColor) -> UIImage? {
        let shortest = min(size.width, size.height)
        return cropToSquare()?.roundCorners(shortest/2, border: border, color: color)
    }

    /**
     creates a new image with a border.

     - parameter border: The size of the border.
     - parameter color: The color of the border.

     - returns: A new image
     */
    public func applyBorder(border: CGFloat,
                            color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let width = CGImageGetWidth(CGImage)
        let height = CGImageGetHeight(CGImage)
        let bits = CGImageGetBitsPerComponent(CGImage)
        let colorSpace = CGImageGetColorSpace(CGImage)
        let bitmapInfo = CGImageGetBitmapInfo(CGImage)
        let context = CGBitmapContextCreate(nil, width, height, bits, 0, colorSpace, bitmapInfo.rawValue)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        CGContextSetRGBStrokeColor(context, red, green, blue, alpha)
        CGContextSetLineWidth(context, border)
        let rect = CGRect(x: 0, y: 0, width: size.width*scale, height: size.height*scale)
        let inset = CGRectInset(rect, border*scale, border*scale)
        CGContextStrokeEllipseInRect(context, inset)
        CGContextDrawImage(context, inset, CGImage)
        guard let bitmapImage = CGBitmapContextCreateImage(context) else {
            return nil
        }
        let image = UIImage(CGImage: bitmapImage)
        UIGraphicsEndImageContext()
        return image
    }

}
