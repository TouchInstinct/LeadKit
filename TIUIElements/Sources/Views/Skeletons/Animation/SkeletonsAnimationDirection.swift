//
//  Copyright (c) 2023 Touch Instinct
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

import struct CoreGraphics.CGPoint

typealias GradientAnimationAnchorPoints = (from: CGPoint, to: CGPoint)

public enum SkeletonsAnimationDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft

    var startPoint: GradientAnimationAnchorPoints {
        switch self {
        case .leftToRight:
            return (from: CGPoint(x: -1, y: 0.5), to: CGPoint(x: 1, y: 0.5))

        case .rightToLeft:
            return (from: Self.leftToRight.startPoint.to, to: Self.leftToRight.startPoint.from)

        case .topToBottom:
            return (from: CGPoint(x: 0.5, y: -1), to: CGPoint(x: 0.5, y: 1))

        case .bottomToTop:
            return (from: Self.topToBottom.startPoint.to, to: Self.topToBottom.startPoint.from)

        case .topLeftToBottomRight:
            return (from: CGPoint(x: -1, y: -1), to: CGPoint(x: 1, y: 1))

        case .topRightToBottomLeft:
            return (from: Self.bottomLeftToTopRight.startPoint.to, to: Self.bottomLeftToTopRight.startPoint.from)

        case .bottomLeftToTopRight:
            return (from: CGPoint(x: -1, y: 2), to: CGPoint(x: 1, y: 0))

        case .bottomRightToTopLeft:
            return (from: Self.topLeftToBottomRight.startPoint.to, to: Self.topLeftToBottomRight.startPoint.from)
        }
    }

    var endPoint: GradientAnimationAnchorPoints {
        switch self {
        case .leftToRight:
            return (from: CGPoint(x: 0, y: 0.5), to: CGPoint(x: 2, y: 0.5))

        case .rightToLeft:
            return (from: Self.leftToRight.endPoint.to, to: Self.leftToRight.endPoint.from)

        case .topToBottom:
            return (from: CGPoint(x: 0.5, y: 0), to: CGPoint(x: 0.5, y: 2))

        case .bottomToTop:
            return (from: Self.topToBottom.endPoint.to, to: Self.topToBottom.endPoint.from)

        case .topLeftToBottomRight:
            return (from: CGPoint(x: 0, y: 0), to: CGPoint(x: 2, y: 2))

        case .topRightToBottomLeft:
            return (from: Self.bottomLeftToTopRight.endPoint.to, to: Self.bottomLeftToTopRight.endPoint.from)

        case .bottomLeftToTopRight:
            return (from: CGPoint(x: 0, y: 1), to: CGPoint(x: 2, y: -1))

        case .bottomRightToTopLeft:
            return (from: Self.topLeftToBottomRight.endPoint.to, to: Self.topLeftToBottomRight.endPoint.from)
        }
    }
}
