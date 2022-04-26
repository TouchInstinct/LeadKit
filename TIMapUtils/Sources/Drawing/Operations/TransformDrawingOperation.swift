//
//  Copyright (c) 2022 Touch Instinct
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

public struct TransformDrawingOperation: OrientationAwareDrawingOperation {
    public var image: CGImage
    public var imageSize: CGSize
    public var maxNewSize: CGSize
    public var resizeMode: ResizeMode
    public var offset: CGPoint
    public var flipHorizontallyDuringDrawing: Bool
    public var cropToImageBounds: Bool
    public var interpolationQuality: CGInterpolationQuality

    private var resizedRect: CGRect {
        imageSize.resizeRect(forNewSize: maxNewSize, resizeMode: resizeMode)
    }

    public init(image: CGImage,
                imageSize: CGSize,
                maxNewSize: CGSize,
                resizeMode: ResizeMode = .scaleAspectFit,
                offset: CGPoint = .zero,
                flipHorizontallyDuringDrawing: Bool = true,
                cropToImageBounds: Bool = false,
                interpolationQuality: CGInterpolationQuality = .default) {

        self.image = image
        self.imageSize = imageSize
        self.maxNewSize = maxNewSize
        self.resizeMode = resizeMode
        self.offset = offset
        self.flipHorizontallyDuringDrawing = flipHorizontallyDuringDrawing
        self.cropToImageBounds = cropToImageBounds
        self.interpolationQuality = interpolationQuality
    }

    // MARK: - DrawingOperation

    public func affectedArea(in context: CGContext? = nil) -> CGRect {
        if cropToImageBounds {
            return CGRect(origin: offset, size: resizedRect.size)
        } else {
            return resizedRect.offset(by: offset)
        }
    }

    public func apply(in context: CGContext) {
        apply(in: context) {
            $0.interpolationQuality = interpolationQuality

            $0.draw(image, in: affectedAreaForDrawing(in: $0))
        }
    }
}
