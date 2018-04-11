//
//  Copyright (c) 2018 Touch Instinct
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

struct RotateDrawingOperation: DrawingOperation {

    private let image: CGImage
    private let imageSize: CGSize
    private let radians: CGFloat

    private let translateRect: CGRect

    public init(image: CGImage, imageSize: CGSize, radians: CGFloat, clockwise: Bool = true) {
        self.image = image
        self.imageSize = imageSize
        self.radians = clockwise ? radians : -radians

        let transform = CGAffineTransform(rotationAngle: radians)
        let imageRect = CGRect(origin: .zero, size: imageSize)

        translateRect = CGRect(origin: .zero, size: imageRect.applying(transform).size)
    }

    public var contextSize: CGContextSize {
        return translateRect.size.ceiledContextSize
    }

    public func apply(in context: CGContext) {
        context.translateBy(x: translateRect.midX, y: translateRect.midY)
        context.rotate(by: radians)

        context.scaleBy(x: 1.0, y: -1.0)

        let imageLocation = CGRect(origin: CGPoint(x: -imageSize.width / 2, y: -imageSize.height / 2),
                                   size: imageSize)

        context.draw(image, in: imageLocation)
    }

}
