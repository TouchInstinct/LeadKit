//
//  UIImage+Cropping.swift
//  LeadKit
//
//  Created by Николай Ашанин on 28.09.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     creates a cropped copy of an image.

     - parameter bounds: The bounds of the rectangle inside the image.

     - returns: A new image
     */
    public func crop(bounds: CGRect) -> UIImage? {
        guard let cgImage = CGImageCreateWithImageInRect(CGImage, bounds) else {
            return nil
        }
        return UIImage(CGImage: cgImage,
                       scale: 0.0,
                       orientation: imageOrientation)
    }

    /**
     crop image to square

     - returns: cropped image
     */
    public func cropToSquare() -> UIImage? {
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        let shortest = min(scaledSize.width, scaledSize.height)
        let left: CGFloat = scaledSize.width > shortest ? (scaledSize.width-shortest)/2 : 0
        let top: CGFloat = scaledSize.height > shortest ? (scaledSize.height-shortest)/2 : 0
        let rect = CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height)
        let insetRect = CGRectInset(rect, left, top)
        return crop(insetRect)
    }

}
