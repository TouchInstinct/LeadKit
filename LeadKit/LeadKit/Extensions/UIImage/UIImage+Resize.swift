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

}
