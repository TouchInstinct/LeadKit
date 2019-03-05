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

struct RoundDrawingOperation: DrawingOperation {

    private let image: CGImage
    private let imageSize: CGSize
    private let radius: CGFloat

    public init(image: CGImage, imageSize: CGSize, radius: CGFloat) {
        self.image = image
        self.imageSize = imageSize
        self.radius = radius
    }

    public var contextSize: CGContextSize {
        return imageSize.ceiledContextSize
    }

    public func apply(in context: CGContext) {
        let imageLocation = CGRect(origin: .zero, size: imageSize)

        context.addPath(UIBezierPath(roundedRect: imageLocation, cornerRadius: radius).cgPath)
        context.clip()
        context.draw(image, in: imageLocation)
    }
}
