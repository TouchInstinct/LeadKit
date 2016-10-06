//
//  UIImage+Extensions.swift
//  LeadKit
//
//  Created by Ivan Smolin on 05/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     method which creates new UIImage instance filled by given color

     - parameter color:  color to fill
     - parameter size:   size of new image

     - returns: new instanse of UIImage with given size and color
     */

    public convenience init?(color: UIColor, size: CGSize) {
        let cgImage = CGImage.create(color: color.cgColor,
                                     width: Int(ceil(size.width)),
                                     height: Int(ceil(size.height)))

        guard let image = cgImage else {
            return nil
        }

        self.init(cgImage: image)
    }

    /**
     creates an image from a UIView.

     - parameter fromView: The source view.

     - returns A new image or nil if something goes wrong.
     */

    public convenience init?(fromView view: UIView) {
        guard let cgImage = CGImage.create(fromView: view) else {
            return nil
        }

        self.init(cgImage: cgImage)
    }

    /**
     method which render current template CGImage into new image using given color

     - parameter withColor: color which used to fill template image

     - returns: new CGImage rendered with given color or nil if something goes wrong
     */
    public func renderTemplate(withColor color: UIColor) -> UIImage? {
        return cgImage?.renderTemplate(withColor: color.cgColor)?.uiImage
    }

    /**
     creates a new image with rounded corners and border.

     - parameter cornerRadius: The corner radius.
     - parameter border: The size of the border.
     - parameter color: The color of the border.
     - parameter extendSize: Extend result image size and don't overlap source image by border.

     - returns: A new image
     */
    public func roundCorners(cornerRadius: CGFloat,
                             borderWidth: CGFloat,
                             color: UIColor,
                             extendSize: Bool = false) -> UIImage? {

        let rounded = cgImage?.round(withRadius: cornerRadius)

        return rounded?.applyBorder(width: borderWidth,
                                    color: color.cgColor,
                                    radius: cornerRadius,
                                    extendSize: extendSize)?.uiImage
    }

    /**
     creates a new circle image.

     - returns: A new image
     */
    public func roundCornersToCircle() -> UIImage? {
        return cgImage?.round(withRadius: CGFloat(min(size.width, size.height) / 2))?.uiImage
    }

    /**
     creates a new circle image with a border.

     - parameter border: CGFloat The size of the border.
     - parameter color: UIColor The color of the border.
     - parameter extendSize: Extend result image size and don't overlap source image by border.

     - returns: UIImage?
     */
    public func roundCornersToCircle(borderWidth: CGFloat,
                                     borderColor: UIColor,
                                     extendSize: Bool = false) -> UIImage? {

        let radius = CGFloat(min(size.width, size.height) / 2)
        let rounded = cgImage?.round(withRadius: radius)

        return rounded?.applyBorder(width: borderWidth,
                                    color: borderColor.cgColor,
                                    radius: radius,
                                    extendSize: extendSize)?.uiImage
    }

    /**
     creates a resized copy of an image.

     - parameter newSize: the new size of the image.
     - parameter contentMode: the way to handle the content in the new size.

     - returns: a new image
     */
    public func resize(newSize: CGSize, contentMode: ImageContentMode = .scaleToFill) -> UIImage? {
        return cgImage?.resize(newSize: newSize, contentMode: contentMode)?.uiImage
    }

    /**
     creates a cropped copy of an image.

     - parameter to: The bounds of the rectangle inside the image.

     - returns: A new image
     */
    public func crop(to bounds: CGRect) -> UIImage? {
        return cgImage?.cropping(to: bounds)?.uiImage
    }

    /**
     crop image to square from center

     - returns: cropped image
     */
    public func cropFromCenterToSquare() -> UIImage? {
        return cgImage?.cropFromCenterToSquare()?.uiImage
    }

}

public extension CGImage {

    public var uiImage: UIImage {
        return UIImage(cgImage: self)
    }

}
