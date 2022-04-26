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

public protocol OrientationAwareDrawingOperation: DrawingOperation {
    var flipHorizontallyDuringDrawing: Bool { get set }
}

extension OrientationAwareDrawingOperation {
    func apply(in context: CGContext, operation: (CGContext) -> Void) {
        if flipHorizontallyDuringDrawing {
            let flipVertical = CGAffineTransform(a: 1,
                                                 b: 0,
                                                 c: 0,
                                                 d: -1,
                                                 tx: 0,
                                                 ty: affectedArea(in: context).height)

            context.concatenate(flipVertical)
            operation(context)
            context.concatenate(flipVertical.inverted())
        } else {
            operation(context)
        }
    }

    func offsetForDrawing(_ offset: CGPoint) -> CGPoint {
        flipHorizontallyDuringDrawing ? offset.horizontallyFlipped() : offset
    }

    func affectedAreaForDrawing(in context: CGContext?) -> CGRect {
        var area = affectedArea(in: context)
        area.origin = offsetForDrawing(area.origin)

        return area
    }
}
