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

struct PaddingDrawingOperation: DrawingOperation {

    private let image: CGImage
    private let imageSize: CGSize
    private let padding: CGFloat

    public init(image: CGImage, imageSize: CGSize, padding: CGFloat) {
        self.image = image
        self.imageSize = imageSize
        self.padding = padding
    }

    public var contextSize: CGContextSize {
        let width = Int(ceil(imageSize.width + padding * 2))
        let height = Int(ceil(imageSize.height + padding * 2))

        return (width: width, height: height)
    }

    public func apply(in context: CGContext) {
        // Draw the image in the center of the context, leaving a gap around the edges
        let imageLocation = CGRect(x: padding,
                                   y: padding,
                                   width: imageSize.width,
                                   height: imageSize.height)

        context.addRect(imageLocation)
        context.clip()

        context.draw(image, in: imageLocation)
    }
}
