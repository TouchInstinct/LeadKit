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

import UIKit

public struct BorderDrawingOperation: DrawingOperation {
    public var frameableContentSize: CGSize
    public var border: CGFloat
    public var color: CGColor
    public var radius: CGFloat
    public var exteriorBorder: Bool

    public init(frameableContentSize: CGSize,
                border: CGFloat,
                color: CGColor,
                radius: CGFloat,
                exteriorBorder: Bool) {

        self.frameableContentSize = frameableContentSize
        self.border = border
        self.color = color
        self.radius = radius
        self.exteriorBorder = exteriorBorder
    }

    // MARK: - DrawingOperation

    public func affectedArea(in context: CGContext?) -> CGRect {
        let margin = exteriorBorder ? border : 0

        let width = frameableContentSize.width + margin * 2
        let height = frameableContentSize.height + margin * 2

        return CGRect(origin: .zero,
                      size: CGSize(width: width, height: height))
    }

    public func apply(in context: CGContext) {
        let drawArea = affectedArea(in: context)

        let ctxSize = drawArea.size.ceiledContextSize

        let ctxRect = CGRect(origin: .zero, size: CGSize(width: ctxSize.width, height: ctxSize.height))

        let widthDiff = CGFloat(ctxSize.width) - drawArea.width // difference between context width and real width
        let heightDiff = CGFloat(ctxSize.height) - drawArea.height // difference between context height and real height
        let inset = ctxRect.insetBy(dx: border / 2 + widthDiff, dy: border / 2 + heightDiff)

        context.setStrokeColor(color)

        if radius != 0 {
            context.setLineWidth(border)

            let path = CGPath(roundedRect: inset,
                              cornerWidth: radius,
                              cornerHeight: radius,
                              transform: nil)
            context.addPath(path)
            context.strokePath()
        } else {
            context.stroke(inset, width: border)
        }
    }
}
