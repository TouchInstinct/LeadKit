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

public struct SolidFillDrawingOperation: DrawingOperation {
    public enum Shape {
        case rect(CGRect)
        case ellipse(CGRect)
        case path(CGPath)
    }

    public var color: CGColor
    public var shape: Shape

    public init(color: CGColor, shape: Shape) {
        self.color = color
        self.shape = shape
    }

    public init(color: CGColor, rect: CGRect) {
        self.init(color: color, shape: .rect(rect))
    }

    public init(color: CGColor, ellipseRect: CGRect) {
        self.init(color: color, shape: .ellipse(ellipseRect))
    }

    public init(color: CGColor, path: CGPath) {
        self.init(color: color, shape: .path(path))
    }

    // MARK: - DrawingOperation

    public func affectedArea(in context: CGContext? = nil) -> CGRect {
        switch shape {
        case let .rect(rect):
            return rect
        case let .ellipse(rect):
            return rect
        case let .path(path):
            return path.boundingBox
        }
    }

    public func apply(in context: CGContext) {
        context.setFillColor(color)

        switch shape {
        case let .rect(rect):
            context.fill(rect)
        case let .ellipse(rect):
            context.fillEllipse(in: rect)
        case let .path(path):
            context.addPath(path)
            context.fillPath()
        }
    }
}
