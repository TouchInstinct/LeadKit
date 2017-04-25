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

import CoreGraphics

public extension CGImage {

    /// Creates a new image with rounded corners.
    ///
    /// - Parameter radius: The corner radius.
    /// - Returns: New image with rounded corners or nil if something goes wrong.
    public func round(withRadius radius: CGFloat) -> CGImage? {
        guard let ctx = CGContext.create(forCGImage: self) ?? CGContext.create(width: width, height: height) else {
            return nil
        }

        ctx.addPath(UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath)
        ctx.clip()
        ctx.draw(self, in: bounds)

        return ctx.makeImage()
    }

    /// Creates a new image with a border.
    ///
    /// - Parameters:
    ///   - border: The size of the border.
    ///   - color: The color of the border.
    ///   - radius: The corner radius.
    ///   - extendSize: Extend result image size and don't overlap source image by border.
    /// - Returns: A new image with border or nil if something goes wrong..
    public func applyBorder(width border: CGFloat,
                            color: CGColor,
                            radius: CGFloat = 0,
                            extendSize: Bool = false) -> CGImage? {

        let offset = extendSize ? border : 0

        let newWidth = CGFloat(width) + offset * 2
        let newHeight = CGFloat(height) + offset * 2

        let ctxWidth = Int(ceil(newWidth))
        let ctxHeight = Int(ceil(newHeight))

        let ctxRect = CGRect(origin: CGPoint.zero, size: CGSize(width: newWidth, height: newHeight))

        let context = CGContext.create(width: ctxWidth,
                                       height: ctxHeight,
                                       bitmapInfo: bitmapInfo,
                                       colorSpace: colorSpace ?? CGColorSpaceCreateDeviceRGB(),
                                       bitsPerComponent: bitsPerComponent)

        guard let ctx = context ?? CGContext.create(width: width, height: height) else {
            return nil
        }

        ctx.draw(self, in: CGRect(x: offset, y: offset, width: CGFloat(width), height: CGFloat(height)))

        ctx.setStrokeColor(color)

        let widthDiff = CGFloat(ctxWidth) - newWidth // difference between context width and real width
        let heightDiff = CGFloat(ctxWidth) - newWidth // difference between context height and real height

        let inset = ctxRect.insetBy(dx: border / 2 + widthDiff, dy: border / 2 + heightDiff)

        if radius != 0 {
            ctx.setLineWidth(border)
            ctx.addPath(UIBezierPath(roundedRect: inset, cornerRadius: radius).cgPath)
            ctx.strokePath()
        } else {
            ctx.stroke(inset, width: border)
        }

        return ctx.makeImage()
    }

    /// Creates a resized copy of an image.
    ///
    /// - Parameters:
    ///   - newSize: The new size of the image.
    ///   - origin: The point where to place resized image
    /// - Returns: A new resized image or nil if something goes wrong.
    public func resize(to newSize: CGSize, usingOrigin origin: CGPoint = .zero) -> CGImage? {
        let ctxWidth = Int(ceil(newSize.width))
        let ctxHeight = Int(ceil(newSize.height))

        let context = CGContext.create(width: ctxWidth,
                                       height: ctxHeight,
                                       bitmapInfo: bitmapInfo,
                                       colorSpace: colorSpace ?? CGColorSpaceCreateDeviceRGB(),
                                       bitsPerComponent: bitsPerComponent)

        guard let ctx = context ?? CGContext.create(width: ctxWidth, height: ctxHeight) else {
            return nil
        }

        let resizeRect = CGRect(origin: origin,
                                size: CGSize(width: ctxWidth, height: ctxHeight))

        ctx.interpolationQuality = .high
        ctx.draw(self, in: resizeRect)

        return ctx.makeImage()
    }

    /// Creates a copy of the image with border of the given size added around its edges.
    ///
    /// - Parameter padding: The padding amount.
    /// - Returns: A new padded image or nil if something goes wrong..
    public func applyPadding(_ padding: CGFloat) -> CGImage? {
        let ctxWidth = Int(ceil(CGFloat(width) + padding * 2))
        let ctxHeight = Int(ceil(CGFloat(height) + padding * 2))

        let context = CGContext.create(width: ctxWidth,
                                       height: ctxHeight,
                                       bitmapInfo: bitmapInfo,
                                       colorSpace: colorSpace ?? CGColorSpaceCreateDeviceRGB(),
                                       bitsPerComponent: bitsPerComponent)

        guard let ctx = context ?? CGContext.create(width: ctxWidth, height: ctxHeight) else {
            return nil
        }

        // Draw the image in the center of the context, leaving a gap around the edges
        let imageLocation = CGRect(x: padding,
                                   y: padding,
                                   width: CGFloat(width),
                                   height: CGFloat(height))

        ctx.addRect(imageLocation)
        ctx.clip()

        ctx.draw(self, in: imageLocation)

        return ctx.makeImage()
    }

}
