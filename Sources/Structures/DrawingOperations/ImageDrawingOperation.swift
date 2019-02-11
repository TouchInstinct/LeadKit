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

struct ImageDrawingOperation: DrawingOperation {

    private let image: CGImage
    private let newSize: CGSize
    private let origin: CGPoint
    public let opaque: Bool
    private let flipY: Bool

    public init(image: CGImage,
                newSize: CGSize,
                origin: CGPoint = .zero,
                opaque: Bool = false,
                flipY: Bool = false) {

        self.image = image
        self.newSize = newSize
        self.origin = origin
        self.opaque = opaque
        self.flipY = flipY
    }

    public var contextSize: CGContextSize {
        return newSize.ceiledContextSize
    }

    public func apply(in context: CGContext) {
        if flipY {
            context.translateBy(x: 0, y: newSize.height)
            context.scaleBy(x: 1, y: -1)
        }

        context.interpolationQuality = .high
        context.draw(image, in: CGRect(origin: origin, size: newSize))
    }
}
