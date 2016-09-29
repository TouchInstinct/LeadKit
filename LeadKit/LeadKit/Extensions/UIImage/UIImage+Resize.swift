//
//  UIImage+Resize.swift
//  LeadKit
//
//  Created by Ivan Smolin on 07/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     method which render current UIImage for specific size and return new UIImage

     - parameter size: size of new image
     - parameter opaque: a flag indicating whether the bitmap is opaque (default: False)

     - returns: new instance of UIImage rendered with given size
     */
    public func renderWithSize(size: CGSize, opaque: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)

        defer { UIGraphicsEndImageContext() }

        drawInRect(CGRect(origin: CGPoint.zero, size: size))

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /**
     creates a resized copy of an image.

     - parameter size: the new size of the image.
     - parameter contentMode: the way to handle the content in the new size.

     - returns: a new image
     */
    public func resize(size: CGSize,
                contentMode: UIImageContentMode = .ScaleToFill) -> UIImage? {
        let horizontalRatio = size.width / size.width
        let verticalRatio = size.height / size.height
        var ratio: CGFloat = 1

        switch contentMode {
        case .ScaleToFill:
            ratio = 1
        case .ScaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        case .ScaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: size.width * ratio, height: size.height * ratio)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(nil,
                                            Int(rect.size.width),
                                            Int(rect.size.height), 8, 0, colorSpace,
                                            bitmapInfo.rawValue)
        let transform = CGAffineTransformIdentity
        CGContextConcatCTM(context, transform)
        // Set the quality level to use when rescaling
        guard let interpolationQuality = CGInterpolationQuality(rawValue: 3) else {
            return nil
        }
        CGContextSetInterpolationQuality(context, interpolationQuality)
        CGContextDrawImage(context, rect, CGImage)

        guard let newContext = context else {
            return nil
        }
        let newImage = UIImage(CGImage: CGBitmapContextCreateImage(newContext),
                               scale: scale,
                               orientation: imageOrientation)
        return newImage
    }

}
