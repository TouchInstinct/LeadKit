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

@available(iOS 10.0, tvOS 10.0, *)
public extension UIImage {

    /// Creates an image filled by given color.
    ///
    /// - Parameters:
    ///   - color: The color to fill
    ///   - size: The size of an new image.
    ///   - scale: The scale of image.
    /// - Returns: A new instanse of UIImage with given size and color.
    public static func imageWith(color: UIColor, size: CGSize) -> UIImage {
        let width = Int(ceil(size.width))
        let height = Int(ceil(size.height))

        let operation = SolidFillDrawingOperation(color: color.cgColor, width: width, height: height)

        return operation.imageFromNewRenderer(scale: UIScreen.main.scale)
    }

    /// Creates an image from a UIView.
    ///
    /// - Parameter fromView: The source view.
    /// - Returns: A new instance of UIImage or nil if something goes wrong.
    public static func imageFrom(view: UIView) -> UIImage {
        let operation = CALayerDrawingOperation(layer: view.layer, size: view.bounds.size)

        return operation.imageFromNewRenderer(scale: UIScreen.main.scale)
    }

    /// Render current template UIImage into new image using given color.
    ///
    /// - Parameter color: Color to fill template image.
    /// - Returns: A new UIImage rendered with given color.
    public func renderTemplate(withColor color: UIColor) -> UIImage {
        guard let image = cgImage else {
            return self
        }

        let operation = TemplateDrawingOperation(image: image,
                                                 imageSize: size,
                                                 color: color.cgColor)

        return operation.imageFromNewRenderer(scale: scale)
    }

    /// Creates a new image with rounded corners and border.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius.
    ///   - borderWidth: The size of the border.
    ///   - color: The color of the border.
    ///   - extendSize: Extend result image size and don't overlap source image by border.
    /// - Returns: A new image with rounded corners.
    public func roundCorners(cornerRadius: CGFloat,
                             borderWidth: CGFloat,
                             color: UIColor,
                             extendSize: Bool = false) -> UIImage {

        guard let image = cgImage else {
            return self
        }

        let roundOperation = RoundDrawingOperation(image: image,
                                                   imageSize: size,
                                                   radius: cornerRadius)

        guard let roundImage = roundOperation.imageFromNewRenderer(scale: scale).cgImage else {
            return self
        }

        let borderOperation = BorderDrawingOperation(image: roundImage,
                                                     imageSize: size,
                                                     border: borderWidth,
                                                     color: color.cgColor,
                                                     radius: cornerRadius,
                                                     extendSize: extendSize)

        return borderOperation.imageFromNewRenderer(scale: scale)
    }

    /// Creates a new circle image.
    ///
    /// - Returns: A new circled image.
    public func roundCornersToCircle() -> UIImage {
        guard let image = cgImage else {
            return self
        }

        let radius = CGFloat(min(size.width, size.height) / 2)

        let operation = RoundDrawingOperation(image: image,
                                              imageSize: size,
                                              radius: radius)

        return operation.imageFromNewRenderer(scale: scale).redraw()
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
                                     extendSize: Bool = false) -> UIImage {

        guard let image = cgImage else {
            return self
        }

        let radius = CGFloat(min(size.width, size.height) / 2)

        let roundOperation = RoundDrawingOperation(image: image,
                                                   imageSize: size,
                                                   radius: radius)

        guard let roundImage = roundOperation.imageFromNewRenderer(scale: scale).cgImage else {
            return self
        }

        let borderOperation = BorderDrawingOperation(image: roundImage,
                                                     imageSize: size,
                                                     border: borderWidth,
                                                     color: borderColor.cgColor,
                                                     radius: radius,
                                                     extendSize: extendSize)

        return borderOperation.imageFromNewRenderer(scale: scale)
    }

    /// Creates a resized copy of an image.
    ///
    /// - Parameters:
    ///   - newSize: The new size of the image.
    ///   - contentMode: The way to handle the content in the new size.
    ///   - cropToImageBounds: Should output image size match resized image size.
    /// Note: If passed true with ResizeMode.scaleAspectFit content mode it will give the original image.
    /// - Returns: A new image scaled to new size.
    public func resize(newSize: CGSize,
                       contentMode: ResizeMode = .scaleToFill,
                       cropToImageBounds: Bool = false) -> UIImage {

        guard let image = cgImage else {
            return self
        }

        let operation = ResizeDrawingOperation(image: image,
                                               imageSize: size,
                                               preferredNewSize: newSize,
                                               resizeMode: contentMode,
                                               cropToImageBounds: cropToImageBounds)

        return operation.imageFromNewRenderer(scale: scale).redraw()
    }

    /// Adds an alpha channel if UIImage doesn't already have one.
    ///
    /// - Returns: A copy of the given image, adding an alpha channel if it doesn't already have one.
    public func applyAlpha() -> UIImage {
        guard let image = cgImage, !image.hasAlpha else {
            return self
        }

        let operation = ImageDrawingOperation(image: image,
                                              newSize: size,
                                              opaque: false)

        return operation.imageFromNewRenderer(scale: scale).redraw()
    }

    /// Creates a copy of the image with border of the given size added around its edges.
    ///
    /// - Parameter padding: The padding amount.
    /// - Returns: A new padded image or nil if something goes wrong.
    public func applyPadding(_ padding: CGFloat) -> UIImage {
        guard let image = cgImage else {
            return self
        }

        let operation = PaddingDrawingOperation(image: image, imageSize: size, padding: padding)

        return operation.imageFromNewRenderer(scale: scale).redraw()
    }

    /// Workaround to fix flipped image rendering (by Y)
    private func redraw() -> UIImage {
        guard let image = cgImage else {
            return self
        }

        let operation = ImageDrawingOperation(image: image, newSize: size)

        return operation.imageFromNewRenderer(scale: scale)
    }

}

@available(iOS 10.0, tvOS 10.0, *)
private extension DrawingOperation {

    func imageFromNewRenderer(scale: CGFloat) -> UIImage {
        let ctxSize = contextSize
        let size = CGSize(width: ctxSize.width, height: ctxSize.height)
        let format = UIGraphicsImageRendererFormat()
        format.opaque = opaque
        format.scale = scale

        return UIGraphicsImageRenderer(size: size, format: format).image {
            self.apply(in: $0.cgContext)
        }
    }

}
