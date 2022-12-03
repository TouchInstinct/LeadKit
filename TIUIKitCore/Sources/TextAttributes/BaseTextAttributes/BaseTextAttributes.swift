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

import UIKit
import TISwiftUtils

/// Base set of attributes to configure appearance of text.
open class BaseTextAttributes {

    public let font: UIFont
    public let color: UIColor
    public let paragraphStyle: NSParagraphStyle
    public let numberOfLines: Int

    open var attributedStringAttributes: [NSAttributedString.Key : Any] {
        [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
    }

    public init(font: UIFont,
                color: UIColor,
                numberOfLines: Int,
                paragraphStyleConfiguration: ParameterClosure<NSMutableParagraphStyle>) {

        self.font = font
        self.color = color

        let mutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyleConfiguration(mutableParagraphStyle)

        self.paragraphStyle = mutableParagraphStyle
        self.numberOfLines = numberOfLines
    }

    // MARK: - UI elements appearance configuration

    private func configure<T: BaseTextAttributesConfigurable>(textContainer: T) {
        textContainer.set(font: font)
        textContainer.set(color: color)
        textContainer.set(alignment: paragraphStyle.alignment)
    }

    open func configure(label: UILabel) {
        configure(textContainer: label)

        label.numberOfLines = numberOfLines
    }

    open func configure(textField: UITextField) {
        configure(textContainer: textField)
    }

    open func configure(textView: UITextView) {
        configure(textContainer: textView)
    }

    open func configure(button: UIButton, for state: UIControl.State) {
        if let buttonLabel = button.titleLabel {
            configure(label: buttonLabel)
        }

        button.setTitleColor(color, for: state)
    }

    // MARK: - UI elements text configuration

    private func configure<T>(textContainer: T,
                              with string: String?,
                              appearanceConfiguration: (T) -> Void,
                              textConfiguration: (String?) -> Void,
                              attributedTextConfiguration: (NSAttributedString?) -> Void) {

        let lineHeightMultipleIsUnsetOrDefault = [NSParagraphStyle().lineHeightMultiple, 1.0].contains(paragraphStyle.lineHeightMultiple)

        if lineHeightMultipleIsUnsetOrDefault {
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

    open func configure(textView: UITextView, with string: String?) {
        configure(textContainer: textView,
                  with: string,
                  appearanceConfiguration: configure(textView:),
                  textConfiguration: { textView.text = $0 },
                  attributedTextConfiguration: { textView.attributedText = $0 })
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

    // MARK: - Attributed string manipulation

    open func attributedString(for string: String) -> NSAttributedString {
        NSAttributedString(string: string, attributes: attributedStringAttributes)
    }

    open func apply(in attributedString: NSMutableAttributedString, at range: NSRange? = nil) {
        attributedString.addAttributes(attributedStringAttributes,
                                       range: range ?? NSRange(location: 0, length: attributedString.length))
    }

    // MARK: - Size calculation

    open func size(of string: String?,
                   with size: CGSize,
                   options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin],
                   context: NSStringDrawingContext? = nil) -> CGSize {

        guard let string = string else {
            return .zero
        }

        let attributedString = NSAttributedString(string: string,
                                                  attributes: attributedStringAttributes)

        return attributedString
            .boundingRect(with: size,
                          options: options,
                          context: context)
            .size
    }

    open func heigth(of string: String?,
                     with width: CGFloat,
                     options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin],
                     context: NSStringDrawingContext? = nil) -> CGFloat {

        size(of: string,
             with: CGSize(width: width, height: .greatestFiniteMagnitude),
             options: options,
             context: context).height
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

    convenience init(font: UIFont,
                     color: UIColor,
                     alignment: NSTextAlignment,
                     lineHeightMultiple: CGFloat,
                     numberOfLines: Int) {

        self.init(font: font,
                  color: color,
                  numberOfLines: numberOfLines) {
            $0.lineHeightMultiple = lineHeightMultiple
            $0.alignment = alignment
        }
    }
}
