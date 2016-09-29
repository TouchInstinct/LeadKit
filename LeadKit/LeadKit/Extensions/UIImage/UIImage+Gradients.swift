//
//  UIImage+Gradients.swift
//  LeadKit
//
//  Created by Николай Ашанин on 28.09.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     creates a gradient color image.

     - parameter gradientColors: An array of colors to use for the gradient.
     - parameter size: Image size (defaults: 10x10)
     */
    public convenience init?(gradientColors: [UIColor],
                      size: CGSize = CGSize(width: 10, height: 10)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject? in return color.CGColor as AnyObject? } as NSArray
        let gradient = CGGradientCreateWithColors(colorSpace, colors, nil)
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    CGPoint(x: 0, y: 0),
                                    CGPoint(x: 0, y: size.height),
                                    CGGradientDrawingOptions(rawValue: 0))
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext().CGImage else {
            return nil
        }
        self.init(CGImage: cgImage)
        UIGraphicsEndImageContext()
    }

    /**
     applies gradient color overlay to an image.

     - parameter gradientColors: An array of colors to use for the gradient.
     - parameter blendMode: The blending type to use.

     - returns: A new image
     */
    public func applyGradientColors(gradientColors: [UIColor],
                             blendMode: CGBlendMode = .Normal) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, blendMode)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        CGContextDrawImage(context, rect, CGImage)
        // Create gradient
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject? in return color.CGColor as AnyObject? } as NSArray
        let gradient = CGGradientCreateWithColors(colorSpace, colors, nil)
        // Apply gradient
        CGContextClipToMask(context, rect, CGImage)
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    CGPoint(x: 0, y: 0),
                                    CGPoint(x: 0, y: size.height),
                                    CGGradientDrawingOptions(rawValue: 0))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /**
     creates a radial gradient.

     - parameter startColor: The start color
     - parameter endColor: The end color
     - parameter radialGradientCenter: The gradient center (default:0.5,0.5).
     - parameter radius: Radius size (default: 0.5)
     - parameter size: Image size (default: 100x100)
     */
    public convenience init?(startColor: UIColor,
                             endColor: UIColor,
                             radialGradientCenter: CGPoint = CGPoint(x: 0.5, y: 0.5),
                             radius: CGFloat = 0.5,
                             size: CGSize = CGSize(width: 100, height: 100)) {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)

        let numLocations: Int = 2
        let locations: [CGFloat] = [0.0, 1.0]

        let startComponents = CGColorGetComponents(startColor.CGColor)
        let endComponents = CGColorGetComponents(endColor.CGColor)

        let components: [CGFloat] = [startComponents[0],
                                     startComponents[1],
                                     startComponents[2],
                                     startComponents[3],
                                     endComponents[0],
                                     endComponents[1],
                                     endComponents[2],
                                     endComponents[3]] as [CGFloat]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, numLocations)

        // Normalize the 0-1 ranged inputs to the width of the image
        let aCenter = CGPoint(x: radialGradientCenter.x * size.width,
                              y: radialGradientCenter.y * size.height)
        let aRadius = (min(size.width, size.height)) * (radius)

        // Draw it
        CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(),
                                    gradient, aCenter, 0,
                                    aCenter, aRadius,
                                    CGGradientDrawingOptions.DrawsAfterEndLocation)
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext().CGImage else {
            return nil
        }
        self.init(CGImage: cgImage)
        // Clean up
        UIGraphicsEndImageContext()
    }

}
