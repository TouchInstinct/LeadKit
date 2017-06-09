//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public extension Support where Base: UIImage {

    /// Creates an image filled by given color.
    ///
    /// - Parameters:
    ///   - color: The color to fill
    ///   - size: The size of an new image.
    /// - Returns: A new instanse of UIImage with given size and color or nil if something goes wrong.
    public static func imageWith(color: UIColor, size: CGSize) -> Support<UIImage>? {
        let width = Int(ceil(size.width))
        let height = Int(ceil(size.height))

        let operation = SolidFillDrawingOperation(color: color.cgColor, width: width, height: height)

        return operation.imageFromNewContext(scale: UIScreen.main.scale)?.support
    }

    /// Creates an image from a UIView.
    ///
    /// - Parameter fromView: The source view.
    /// - Returns: A new instance of UIImage or nil if something goes wrong.
    public static func imageFrom(view: UIView) -> Support<UIImage>? {
        let layerDrawingOperation = CALayerDrawingOperation(layer: view.layer, size: view.bounds.size)

        return layerDrawingOperation.imageFromNewContext(scale: UIScreen.main.scale)?.support.flipY()
    }

    /// Render current template UIImage into new image using given color.
    ///
    /// - Parameter color: Color to fill template image.
    /// - Returns: A new UIImage rendered with given color or nil if something goes wrong.
    public func renderTemplate(withColor color: UIColor) -> Support<UIImage>? {
        guard let image = base.cgImage else {
            return Support<UIImage>(base)
        }

        let operation = TemplateDrawingOperation(image: image,
                                                 imageSize: base.size,
                                                 color: color.cgColor)

        return operation.imageFromNewContext(scale: base.scale)?.support
    }

    /// Creates a new image with rounded corners and border.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius.
    ///   - borderWidth: The size of the border.
    ///   - color: The color of the border.
    ///   - extendSize: Extend result image size and don't overlap source image by border.
    /// - Returns: A new image with rounded corners or nil if something goes wrong.
    public func roundCorners(cornerRadius: CGFloat,
                             borderWidth: CGFloat,
                             color: UIColor,
                             extendSize: Bool = false) -> Support<UIImage>? {

        guard let image = base.cgImage else {
            return Support<UIImage>(base)
        }

        let roundOperation = RoundDrawingOperation(image: image,
                                                   imageSize: base.size,
                                                   radius: cornerRadius)

        guard let roundImage = roundOperation.cgImageFromNewContext(scale: base.scale) else {
            return nil
        }

        let borderOperation = BorderDrawingOperation(image: roundImage,
                                                     imageSize: base.size,
                                                     border: borderWidth,
                                                     color: color.cgColor,
                                                     radius: cornerRadius,
                                                     extendSize: extendSize)

        return borderOperation.imageFromNewContext(scale: base.scale)?.support
    }

    /// Creates a new circle image.
    ///
    /// - Returns: A new circled image or nil if something goes wrong.
    public func roundCornersToCircle() -> Support<UIImage>? {
        guard let image = base.cgImage else {
            return Support<UIImage>(base)
        }

        let radius = CGFloat(min(base.size.width, base.size.height) / 2)

        let operation = RoundDrawingOperation(image: image,
                                              imageSize: base.size,
                                              radius: radius)

        return operation.imageFromNewContext(scale: base.scale)?.support
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
                                     extendSize: Bool = false) -> Support<UIImage>? {

        guard let image = base.cgImage else {
            return Support<UIImage>(base)
        }

        let radius = CGFloat(min(base.size.width, base.size.height) / 2)

        let roundOperation = RoundDrawingOperation(image: image,
                                                   imageSize: base.size,
                                                   radius: radius)

        guard let roundImage = roundOperation.cgImageFromNewContext(scale: base.scale) else {
            return nil
        }

        let borderOperation = BorderDrawingOperation(image: roundImage,
                                                     imageSize: base.size,
                                                     border: borderWidth,
                                                     color: borderColor.cgColor,
                                                     radius: radius,
                                                     extendSize: extendSize)

        return borderOperation.imageFromNewContext(scale: base.scale)?.support
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
                       cropToImageBounds: Bool = false) -> Support<UIImage>? {

        guard let image = base.cgImage else {
            return Support<UIImage>(base)
        }

        let operation = ResizeDrawingOperation(image: image,
                                               imageSize: base.size,
                                               preferredNewSize: newSize,
                                               resizeMode: contentMode,
                                               cropToImageBounds: cropToImageBounds)

        return operation.imageFromNewContext(scale: base.scale)?.support
    }

    /// Adds an alpha channel if UIImage doesn't already have one.
    ///
    /// - Returns: A copy of the given image, adding an alpha channel if it doesn't already have one.
    public func applyAlpha() -> Support<UIImage>? {
        guard let image = base.cgImage, !image.hasAlpha else {
            return Support<UIImage>(base)
        }

        let operation = ImageDrawingOperation(image: image,
                                              newSize: base.size,
                                              opaque: false)

        return operation.imageFromNewContext(scale: base.scale)?.support
    }

    /// Creates a copy of the image with border of the given size added around its edges.
    ///
    /// - Parameter padding: The padding amount.
    /// - Returns: A new padded image or nil if something goes wrong.
    public func applyPadding(_ padding: CGFloat) -> Support<UIImage>? {
        guard let image = base.cgImage else {
            return Support<UIImage>(base)
        }

        let operation = PaddingDrawingOperation(image: image,
                                                imageSize: base.size,
                                                padding: padding)

        return operation.imageFromNewContext(scale: base.scale)?.support
    }

    private func flipY() -> Support<UIImage>? {
        guard let image = base.cgImage else {
            return Support<UIImage>(base)
        }

        let flipOperation = ImageDrawingOperation(image: image,
                                                  newSize: base.size,
                                                  origin: .zero,
                                                  opaque: false,
                                                  flipY: true)

        return flipOperation.imageFromNewContext(scale: base.scale)?.support
    }

}

private extension DrawingOperation {

    func cgImageFromNewContext(scale: CGFloat) -> CGImage? {
        let ctxSize = contextSize

        let intScale = Int(scale)

        let context = CGContext.create(width: ctxSize.width * intScale,
                                       height: ctxSize.height * intScale,
                                       bitmapInfo: opaque ? .opaqueBitmapInfo : .alphaBitmapInfo)

        guard let ctx = context else {
            return nil
        }

        ctx.scaleBy(x: scale, y: scale)

        apply(in: ctx)

        return ctx.makeImage()
    }

    func imageFromNewContext(scale: CGFloat) -> UIImage? {
        guard let image = cgImageFromNewContext(scale: scale) else {
            return nil
        }

        return UIImage(cgImage: image, scale: scale, orientation: .up)
    }

}
