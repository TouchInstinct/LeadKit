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

import TISwiftUtils
import UIKit

open class LabelSkeletonsConfiguration: BaseViewSkeletonsConfiguration {

    public enum LinesAmount {
        case constant(Int)
        case asLabelSize
        case asLabelNumberOfLines
    }

    private var isMultiline = false
    private var labelNumberOfLines: Int = .zero
    private var labelHeight: CGFloat = .zero
    private var font: UIFont?

    public var numberOfLines: LinesAmount
    public var lineHeight: Closure<UIFont?, CGFloat>?
    public var lineSpacing: Closure<UIFont?, CGFloat>?

    public init(numberOfLines: LinesAmount = .constant(3),
                lineHeight: Closure<UIFont?, CGFloat>? = nil,
                lineSpacing: Closure<UIFont?, CGFloat>? = nil,
                shape: Shape = .rectangle(cornerRadius: .zero)) {

        self.numberOfLines = numberOfLines
        self.lineHeight = lineHeight
        self.lineSpacing = lineSpacing

        super.init(shape: shape)
    }

    open override func drawPath(rect: CGRect) -> CGPath {
        /*
         SkeletonLayer
         |-------------------------|
         ||-----------------------|| - first line CGRect(0, 0, rect.width, lineHeight)
         |                         | - spacing
         ||-----------------------|| - second line CGRect(0, lineHeight + spacing, rect.width, lineHeight)
         |                         | - spacing
         ||-----------------------|| - third line CGRect(0, (lineHeight + spacing) * 2, rect.width, lineHeight)
         |-------------------------|
         */
        let path = UIBezierPath()
        let numberOfLines = getNumberOfLines()
        let spacing = getLineSpacing()
        let lineHeight = getLineHeight()
        var cornerRadius = CGFloat.zero

        if case let .rectangle(cornerRadius: radius) = shape {
            cornerRadius = radius / 2
        }

        for lineNumber in 0..<numberOfLines {
            let y = (lineHeight + spacing) * CGFloat(lineNumber)

            path.move(to: CGPoint(x: cornerRadius, y: y))

            path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: y))
            path.addQuadCurve(to: CGPoint(x: rect.width, y: y + cornerRadius),
                              controlPoint: CGPoint(x: rect.width, y: y))

            path.addLine(to: CGPoint(x: rect.width, y: y + lineHeight - cornerRadius))
            path.addQuadCurve(to: CGPoint(x: rect.width - cornerRadius, y: y + lineHeight),
                              controlPoint: CGPoint(x: rect.width, y: y + lineHeight))

            path.addLine(to: CGPoint(x: cornerRadius, y: y + lineHeight))
            path.addQuadCurve(to: CGPoint(x: .zero, y: y + lineHeight - cornerRadius),
                              controlPoint: CGPoint(x: .zero, y: y + lineHeight))

            path.addLine(to: CGPoint(x: .zero, y: y + cornerRadius))
            path.addQuadCurve(to: CGPoint(x: cornerRadius, y: y),
                              controlPoint: CGPoint(x: .zero, y: y))
        }

        return path.cgPath
    }

    open func configureLabelPath(label: UILabel) -> CGPath {
        if case let .custom(path) = shape {
            return path
        }

        isMultiline = label.isMultiline
        font = label.font
        labelNumberOfLines = label.numberOfLines
        labelHeight = label.bounds.height

        return drawPath(rect: label.bounds)
    }

    open func configureTextViewPath(textView: UITextView) -> CGPath {
        if case let .custom(path) = shape {
            return path
        }

        isMultiline = textView.isMultiline
        font = textView.font
        labelNumberOfLines = textView.textContainer.maximumNumberOfLines
        labelHeight = textView.bounds.height

        return drawPath(rect: textView.bounds)
    }

    // MARK: - Private methods

    private func getLineHeight() -> CGFloat {
        if let lineHeight = lineHeight?(font) {
            return lineHeight
        }

        // By default height of the line is equal to 75% of font's size
        return (font?.pointSize ?? 1) * 0.75
    }

    private func getLineSpacing() -> CGFloat {
        if let lineSpacing = lineSpacing?(font) {
            return lineSpacing
        }

        return font?.xHeight ?? .zero
    }

    private func getNumberOfLines() -> Int {
        guard isMultiline else {
            return 1
        }

        switch self.numberOfLines {
        case let .constant(lines):
            return lines

        case .asLabelNumberOfLines:
            return labelNumberOfLines

        case .asLabelSize:
            let lineHeight = getLineHeight()
            return Int(labelHeight / lineHeight)
        }
    }
}
