//
//  CGImage+Transform.swift
//  LeadKit
//
//  Created by Ivan Smolin on 05/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import CoreGraphics

public extension CGImage {

    /**
     creates a new image with rounded corners.

     - parameter withRadius: The corner radius.

     - returns: A new image
     */
    public func round(withRadius radius: CGFloat) -> CGImage? {
        guard let ctx = CGContext.create(forCGImage: self) ?? CGContext.create(width: width, height: height) else {
            return nil
        }

        ctx.addPath(UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath)
        ctx.clip()
        ctx.draw(self, in: bounds)

        return ctx.makeImage()
    }

    /**
     creates a new image with a border.

     - parameter width: The size of the border.
     - parameter color: The color of the border.
     - parameter radius: The corner radius.
     - parameter extendSize: Extend result image size and don't overlap source image by border.

     - returns: A new image
     */
    public func applyBorder(width border: CGFloat,
                            color: CGColor,
                            radius: CGFloat = 0,
                            extendSize: Bool = false) -> CGImage? {

        let offset = extendSize ? border : 0

        let newWidth = CGFloat(width) + offset * 2
        let newHeight = CGFloat(height) + offset * 2

        let ctxWidth = Int(ceil(newWidth))
        let ctxHeight = Int(ceil(newHeight))

        let ctxRect: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: newWidth, height: newHeight))

        let context = CGContext.create(width: ctxWidth,
                                       height: ctxHeight,
                                       bitmapInfo: bitmapInfo,
                                       colorSpace: colorSpace ?? CGColorSpaceCreateDeviceRGB(),
                                       bitsPerComponent: bitsPerComponent)

        guard let ctx = context ?? CGContext.create(width: width, height: height) else {
            return nil
        }

        ctx.draw(self, in: CGRect(x: offset, y: offset, width: CGFloat(width), height: CGFloat(height)))

        ctx.setStrokeColor(color)

        let widthDiff = CGFloat(ctxWidth) - newWidth // difference between context width and real width
        let heightDiff = CGFloat(ctxWidth) - newWidth // difference between context height and real height

        let inset = ctxRect.insetBy(dx: border / 2 + widthDiff, dy: border / 2 + heightDiff)

        if radius != 0 {
            ctx.setLineWidth(border)
            ctx.addPath(UIBezierPath(roundedRect: inset, cornerRadius: radius).cgPath)
            ctx.strokePath()
        } else {
            ctx.stroke(inset, width: border)
        }
        
        return ctx.makeImage()
    }

    /**
     creates a resized copy of an image.

     - parameter newSize: the new size of the image.
     - parameter contentMode: the way to handle the content in the new size.

     - returns: a new image
     */
    public func resize(newSize: CGSize, contentMode: ImageContentMode = .scaleToFill) -> CGImage? {
        let ctxWidth = Int(ceil(newSize.width))
        let ctxHeight = Int(ceil(newSize.height))

        let context = CGContext.create(width: ctxWidth,
                                       height: ctxHeight,
                                       bitmapInfo: bitmapInfo,
                                       colorSpace: colorSpace ?? CGColorSpaceCreateDeviceRGB(),
                                       bitsPerComponent: bitsPerComponent)

        guard let ctx = context ?? CGContext.create(width: ctxWidth, height: ctxHeight) else {
            return nil
        }

        let horizontalRatio = newSize.width / CGFloat(width)
        let verticalRatio = newSize.height / CGFloat(height)

        let ratio: CGFloat

        switch contentMode {
        case .scaleToFill:
            ratio = 1
        case .scaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        case .scaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
        }

        let newImageWidth = contentMode == .scaleToFill ? newSize.width : CGFloat(width) * ratio
        let newImageHeight = contentMode == .scaleToFill ? newSize.height : CGFloat(height) * ratio

        let originX: CGFloat
        let originY: CGFloat

        if newImageWidth > newSize.width {
            originX = (newSize.width - newImageWidth) / 2
        } else if newImageWidth < newSize.width {
            originX = newSize.width / 2 - newImageWidth / 2
        } else {
            originX = 0
        }

        if newImageHeight > newSize.height {
            originY = (newSize.height - newImageHeight) / 2
        } else if newImageHeight < newSize.height {
            originY = newSize.height / 2 - newImageHeight / 2
        } else {
            originY = 0
        }

        let rect = CGRect(origin: CGPoint(x: originX, y: originY),
                          size: CGSize(width: newImageWidth, height: newImageHeight))

        ctx.interpolationQuality = .high
        ctx.draw(self, in: rect)

        return ctx.makeImage()
    }

    /**
     returns a copy of the image with border of the given size added around its edges.

     - parameter padding: The padding amount.

     - returns: A new image.
     */
    public func applyPadding(_ padding: CGFloat) -> CGImage? {
        let ctxWidth = Int(ceil(CGFloat(width) + padding * 2))
        let ctxHeight = Int(ceil(CGFloat(height) + padding * 2))

        let context = CGContext.create(width: ctxWidth,
                                       height: ctxHeight,
                                       bitmapInfo: bitmapInfo,
                                       colorSpace: colorSpace ?? CGColorSpaceCreateDeviceRGB(),
                                       bitsPerComponent: bitsPerComponent)

        guard let ctx = context ?? CGContext.create(width: ctxWidth, height: ctxHeight) else {
            return nil
        }

        // Draw the image in the center of the context, leaving a gap around the edges
        let imageLocation = CGRect(x: padding,
                                   y: padding,
                                   width: CGFloat(width),
                                   height: CGFloat(height))
        
        ctx.addRect(imageLocation)
        ctx.clip()
        
        ctx.draw(self, in: imageLocation)
        
        return ctx.makeImage()
    }
    
}
