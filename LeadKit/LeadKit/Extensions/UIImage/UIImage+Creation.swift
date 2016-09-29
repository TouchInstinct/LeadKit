//
//  UIImage+Creation.swift
//  LeadKit
//
//  Created by Ivan Smolin on 07/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     method which creates new UIImage instance filled by given color

     - parameter color:  color to fill
     - parameter size:   size of new image
     - parameter opaque: a flag indicating whether the bitmap is opaque (default: False)
     - parameter scale:  screen scale (default: 0 (pick a device scale))

     - returns: new instanse of UIImage with given size and color
     */
    public static func imageWith(color: UIColor, size: CGSize, opaque: Bool = false, scale: CGFloat = 0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)

        defer { UIGraphicsEndImageContext() }

        let context = UIGraphicsGetCurrentContext()

        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, CGRect(origin: CGPoint.zero, size: size))

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /**
     creates an image from a UIView.

     - parameter fromView: The source view.

     - returns A new image
     */
    public convenience init?(fromView view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.renderInContext(context)
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext().CGImage else {
            return nil
        }
        self.init(CGImage: cgImage)
        UIGraphicsEndImageContext()
    }

}
