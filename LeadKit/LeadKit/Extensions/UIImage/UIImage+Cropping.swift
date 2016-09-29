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
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        let shortest = min(newSize.width, newSize.height)
        let left: CGFloat = newSize.width > shortest ? (newSize.width-shortest)/2 : 0
        let top: CGFloat = newSize.height > shortest ? (newSize.height-shortest)/2 : 0
        let rect = CGRect(x: 0, y: 0, width: size.width, height: newSize.height)
        let insetRect = CGRectInset(rect, left, top)
        return crop(insetRect)
    }

}
