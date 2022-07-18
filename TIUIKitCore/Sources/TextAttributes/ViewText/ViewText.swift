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

public struct ViewText {
    public let text: String?
    public let attributes: BaseTextAttributes

    public init(text: String?, attributes: BaseTextAttributes) {
        self.text = text
        self.attributes = attributes
    }

    public init(string: String,
                font: UIFont,
                color: UIColor,
                alignment: NSTextAlignment = .natural,
                lineHeightMultiple: CGFloat = 1.0,
                numberOfLines: Int = 1) {

        text = string
        attributes = BaseTextAttributes(font: font,
                                        color: color,
                                        alignment: alignment,
                                        lineHeightMultiple: lineHeightMultiple,
                                        numberOfLines: numberOfLines)
    }

    public func size(maxWidth: CGFloat = .greatestFiniteMagnitude,
                     maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGSize {

        guard let text = text else {
            return .zero
        }

        let attributedString = attributes.attributedString(for: text)

        return attributedString.boundingRect(with: CGSize(width: maxWidth, height: maxHeight),
                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                             context: nil).size
    }

    public func configure(label: UILabel) {
        attributes.configure(label: label, with: text)
    }

    public func configure(textField: UITextField) {
        attributes.configure(textField: textField, with: text)
    }

    public func configure(textView: UITextView) {
        attributes.configure(textView: textView, with: text)
    }

    public func configure(button: UIButton, for state: UIControl.State) {
        attributes.configure(button: button, with: text, for: state)
    }
}
