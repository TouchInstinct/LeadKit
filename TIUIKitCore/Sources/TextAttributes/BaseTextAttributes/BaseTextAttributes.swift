//
//  Copyright (c) 2020 Touch Instinct
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

import UIKit.UIFont
import UIKit.UIColor

/// Base set of attributes to configure appearance of text.
open class BaseTextAttributes {

    /// Text font.
    public let font: UIFont
    /// Text color.
    public let color: UIColor
    /// Text alignment.
    public let alignment: NSTextAlignment
    /// Paragraph line height.
    public let lineHeightMultiple: CGFloat
    /// Number of lines for labels.
    public let numberOfLines: Int

    public init(font: UIFont,
                color: UIColor,
                alignment: NSTextAlignment,
                lineHeightMultiple: CGFloat,
                numberOfLines: Int) {
        self.font = font
        self.color = color
        self.alignment = alignment
        self.lineHeightMultiple = lineHeightMultiple
        self.numberOfLines = numberOfLines
    }

    private func configure<T: BaseTextAttributesConfigurable>(textContainer: T) {
        textContainer.set(font: font)
        textContainer.set(color: color)
        textContainer.set(alignment: alignment)
    }

    open func configure(label: UILabel) {
        configure(textContainer: label)

        label.numberOfLines = numberOfLines
    }

    open func configure(textField: UITextField) {
        configure(textContainer: textField)
    }

    open func configure(button: UIButton, for state: UIControl.State) {
        if let buttonLabel = button.titleLabel {
            configure(label: buttonLabel)
        }

        button.setTitleColor(color, for: state)
    }

    private func configure<T>(textContainer: T,
                              with string: String?,
                              appearanceConfiguration: (T) -> Void,
                              textConfiguration: (String?) -> Void,
                              attributedTextConfiguration: (NSAttributedString?) -> Void) {
        if lineHeightMultiple == 1.0 { // default
            appearanceConfiguration(textContainer)

            textConfiguration(string)
        } else {
            let resultAttributedString: NSAttributedString?

            if let string = string {
                resultAttributedString = attributedString(for: string)
            } else {
                resultAttributedString = nil
            }

            attributedTextConfiguration(resultAttributedString)
        }
    }

    open func configure(label: UILabel, with string: String?) {
        configure(textContainer: label,
                  with: string,
                  appearanceConfiguration: configure(label:),
                  textConfiguration: { label.text = $0 },
                  attributedTextConfiguration: {
                    label.attributedText = $0
                    label.numberOfLines = numberOfLines
                  })
    }

    open func configure(textField: UITextField, with string: String?) {
        configure(textContainer: textField,
                  with: string,
                  appearanceConfiguration: configure(textField:),
                  textConfiguration: { textField.text = $0 },
                  attributedTextConfiguration: { textField.attributedText = $0 })
    }

    open func configure(button: UIButton, with string: String?, for state: UIControl.State) {
        configure(textContainer: button,
                  with: string,
                  appearanceConfiguration: { configure(button: $0, for: state) },
                  textConfiguration: { button.setTitle($0, for: state) },
                  attributedTextConfiguration: {
                    button.setAttributedTitle($0, for: state)
                    button.titleLabel?.numberOfLines = numberOfLines
                  })
    }

    open func attributedString(for string: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]

        return NSAttributedString(string: string, attributes: attributes)
    }
}

public extension BaseTextAttributes {
    typealias FigmaPercent = CGFloat

    convenience init(font: UIFont,
                     color: UIColor,
                     alignment: NSTextAlignment,
                     isMultiline: Bool,
                     lineHeight: FigmaPercent = 100.0) {

        self.init(font: font,
                  color: color,
                  alignment: alignment,
                  lineHeightMultiple: lineHeight / 100.0,
                  numberOfLines: isMultiline ? 0 : 1)
    }
}
