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
import Foundation.NSAttributedString
import CoreText

public struct TextDrawingOperation: OrientationAwareDrawingOperation {
    public var text: String
    public var font: CTFont
    public var textColor: CGColor
    public var flipHorizontallyDuringDrawing: Bool
    public var desiredOffset: CGPoint

    private var line: CTLine {
        let textAttributes: [NSAttributedString.Key : Any] = [
            .font: font,
            .foregroundColor: textColor
        ]

        let attributedString = NSAttributedString(string: text, attributes: textAttributes)

        return CTLineCreateWithAttributedString(attributedString)
    }

    public init(text: String,
                font: CTFont,
                textColor: CGColor,
                flipHorizontallyDuringDrawing: Bool = true,
                desiredOffset: CGPoint = .zero) {

        self.text = text
        self.font = font
        self.textColor = textColor
        self.flipHorizontallyDuringDrawing = flipHorizontallyDuringDrawing
        self.desiredOffset = desiredOffset
    }

    public func affectedArea(in context: CGContext? = nil) -> CGRect {
        CGRect(origin: desiredOffset, size: CTLineGetImageBounds(line, context).size)
    }

    public func apply(in context: CGContext) {
        apply(in: context) {
            let originForDrawing = offsetForDrawing(CTLineGetImageBounds(line, context).origin)
            let desiredOffsetForDrawing = offsetForDrawing(desiredOffset)
            let textPosition = CGPoint(x: desiredOffsetForDrawing.x - originForDrawing.x,
                                       y: desiredOffsetForDrawing.y - originForDrawing.y)
            
            $0.textPosition = textPosition

            CTLineDraw(line, $0)
        }
    }
}
