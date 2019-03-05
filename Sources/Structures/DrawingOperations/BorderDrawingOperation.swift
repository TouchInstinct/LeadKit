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

import CoreGraphics

struct BorderDrawingOperation: DrawingOperation {

    private let image: CGImage
    private let imageSize: CGSize
    private let border: CGFloat
    private let color: CGColor
    private let radius: CGFloat
    private let extendSize: Bool

    public init(image: CGImage,
                imageSize: CGSize,
                border: CGFloat,
                color: CGColor,
                radius: CGFloat,
                extendSize: Bool) {

        self.image = image
        self.imageSize = imageSize
        self.border = border
        self.color = color
        self.radius = radius
        self.extendSize = extendSize
    }

    public var contextSize: CGContextSize {
        let offset = extendSize ? border : 0

        let width = imageSize.width + offset * 2
        let height = imageSize.height + offset * 2

        return CGSize(width: width, height: height).ceiledContextSize
    }

    public func apply(in context: CGContext) {
        let offset = extendSize ? border : 0

        let newWidth = imageSize.width + offset * 2
        let newHeight = imageSize.height + offset * 2

        let ctxSize = contextSize

        let ctxRect = CGRect(origin: .zero, size: CGSize(width: ctxSize.width, height: ctxSize.height))

        let imageRect = CGRect(x: offset, y: offset, width: imageSize.width, height: imageSize.height)

        context.draw(image, in: imageRect)

        context.setStrokeColor(color)

        let widthDiff = CGFloat(ctxSize.width) - newWidth // difference between context width and real width
        let heightDiff = CGFloat(ctxSize.height) - newHeight // difference between context height and real height

        let inset = ctxRect.insetBy(dx: border / 2 + widthDiff, dy: border / 2 + heightDiff)

        if radius != 0 {
            context.setLineWidth(border)
            context.addPath(UIBezierPath(roundedRect: inset, cornerRadius: radius).cgPath)
            context.strokePath()
        } else {
            context.stroke(inset, width: border)
        }
    }
}
