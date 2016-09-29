//
//  UIImage+Text.swift
//  LeadKit
//
//  Created by Николай Ашанин on 28.09.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     creates a text label image.

     - parameter text: The text to use in the label.
     - parameter font: The font (default: System font of size 18)
     - parameter color: The text color (default: White)
     - parameter backgroundColor: The background color (default:Gray).
     - parameter size: Image size (default: 10x10)
     - parameter offset: Center offset (default: 0x0)
     */
    public convenience init?(text: String,
                             font: UIFont = UIFont.systemFontOfSize(18),
                             color: UIColor = UIColor.whiteColor(),
                             backgroundColor: UIColor = UIColor.grayColor(),
                             size: CGSize = CGSize(width: 10, height: 10),
                             offset: CGPoint = CGPoint(x: 0, y: 0)) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.font = font
        label.text = text
        label.textColor = color
        label.textAlignment = .Center
        label.backgroundColor = backgroundColor
        let image = UIImage(fromView: label)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image?.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext().CGImage else {
            return nil
        }
        self.init(CGImage: cgImage)
        UIGraphicsEndImageContext()
    }

}
