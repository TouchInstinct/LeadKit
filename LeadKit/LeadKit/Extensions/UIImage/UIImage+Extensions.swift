//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public extension UIImage {

    /// Creates an image filled by given color.
    ///
    /// - Parameters:
    ///   - color: The color to fill
    ///   - size: The size of an new image.
    /// - Returns: A new instanse of UIImage with given size and color or nil if something goes wrong.
    public convenience init?(color: UIColor, size: CGSize) {
        let cgImage = CGImage.create(color: color.cgColor,
                                     width: Int(ceil(size.width)),
                                     height: Int(ceil(size.height)))

        guard let image = cgImage else {
            return nil
        }

        self.init(cgImage: image)
    }

    /// Creates an image from a UIView.
    ///
    /// - Parameter fromView: The source view.
    /// - Returns: A new instance of UIImage or nil if something goes wrong.
    public convenience init?(fromView view: UIView) {
        guard let cgImage = CGImage.create(fromView: view) else {
            return nil
        }

        self.init(cgImage: cgImage)
    }

    /// Render current template UIImage into new image using given color.
    ///
    /// - Parameter color: Color to fill template image.
    /// - Returns: A new UIImage rendered with given color or nil if something goes wrong.
    public func renderTemplate(withColor color: UIColor) -> UIImage? {
        return cgImage?.renderTemplate(withColor: color.cgColor)?.uiImage
    }

    /// Creates a new image with rounded corners and border.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius.
    ///   - borderWidth: The size of the border.
    ///   - color: The color of the border.
    ///   - extendSize: Extend result image size and don't overlap source image by border.
    /// - Returns: A new image or nil if something goes wrong.
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

    /// Creates a new circle image.
    ///
    /// - Returns: A new circled image or nil if something goes wrong.
    public func roundCornersToCircle() -> UIImage? {
        return cgImage?.round(withRadius: CGFloat(min(size.width, size.height) / 2))?.uiImage
    }

    /// Creates a new circle image with a border.
    ///
    /// - Parameters:
    ///   - borderWidth: The size of the border.
    ///   - borderColor: The color of the border.
    ///   - extendSize: Extend result image size and don't overlap source image by border (default = false).
    /// - Returns: A new image with rounded corners or nil if something goes wrong.
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

    /// Creates a resized copy of an image.
    ///
    /// - Parameters:
    ///   - newSize: The new size of the image.
    ///   - contentMode: The way to handle the content in the new size.
    /// - Returns: A new image scaled to new size.
    public func resize(newSize: CGSize, contentMode: ResizeMode = .scaleToFill) -> UIImage? {
        let resizedRect = size.resizeRect(forNewSize: newSize, resizeMode: contentMode)

        return cgImage?.resize(to: resizedRect.size, usingOrigin: resizedRect.origin)?.uiImage
    }

    /// Creates a resized copy of image using scaleAspectFit strategy.
    ///
    /// - Parameter preferredNewSize: The preferred new size of image.
    /// - Returns: A new image which size may be less then or equals to given preferredSize.
    public func resizeAspectFit(preferredNewSize: CGSize) -> UIImage? {
        let resizeRect = size.resizeRect(forNewSize: preferredNewSize, resizeMode: .scaleAspectFit)

        return cgImage?.resize(to: resizeRect.size)?.uiImage
    }

    /// Creates a cropped copy of image using the data contained within a subregion of an existing image.
    ///
    /// - Parameter bounds: A rectangle whose coordinates specify the area to create an image from.
    /// - Returns: A new image that specifies a subimage of the image.
    /// If the rect parameter defines an area that is not in the image, returns NULL.
    public func crop(to bounds: CGRect) -> UIImage? {
        return cgImage?.cropping(to: bounds)?.uiImage
    }

    /// Crop image with given margin values.
    ///
    /// - Parameters:
    ///   - top: Top margin.
    ///   - left: Left margin.
    ///   - bottom: Bottom margin.
    ///   - right: Right margin.
    /// - Returns: A new image cropped with given paddings or nil if something goes wrong.
    public func crop(top: CGFloat = 0,
                     left: CGFloat = 0,
                     bottom: CGFloat = 0,
                     right: CGFloat = 0) -> UIImage? {

        return cgImage?.crop(top: top,
                             left: left,
                             bottom: bottom,
                             right: right)?.uiImage
    }

    /// Crop image to square from center.
    ///
    /// - Returns: A new cropped image.
    public func cropFromCenterToSquare() -> UIImage? {
        return cgImage?.cropFromCenterToSquare()?.uiImage
    }

    /// Adds an alpha channel if UIImage doesn't already have one.
    ///
    /// - Returns: A copy of the given image, adding an alpha channel if it doesn't already have one.
    public func applyAlpha() -> UIImage? {
        return cgImage?.applyAlpha()?.uiImage
    }

}

public extension CGImage {

    /// Creates new UIImage instance from CGImage.
    public var uiImage: UIImage {
        return UIImage(cgImage: self)
    }

}
