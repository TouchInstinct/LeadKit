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

}
