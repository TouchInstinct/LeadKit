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

/// Enum that describes text with appearance options.
///
/// - string: Regular string with common and often-used text attributes.
/// - attributedString: Attributed string.
public enum ViewText {

    case string(String, textAttributes: BaseTextAttributes)
    case attributedString(NSAttributedString)
}

public extension ViewText {

    /// Convenient initializer for .string case with default alignment parameter.
    ///
    /// - Parameters:
    ///   - string: Text to use.
    ///   - font: Font to use.
    ///   - color: Color to use.
    ///   - alignment: Alignment to use. Default is natural.
    init(string: String, font: UIFont, color: UIColor, alignment: NSTextAlignment = .natural) {
        self = .string(string, textAttributes: BaseTextAttributes(font: font,
                                                                  color: color,
                                                                  alignment: alignment))
    }

    /// Attributed string created using text attributes.
    var attributedString: NSAttributedString {
        switch self {
        case let .string(title, textAttributes):

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAttributes.alignment

            let attributes: [NSAttributedString.Key: Any] = [
                .font: textAttributes.font,
                .foregroundColor: textAttributes.color,
                .paragraphStyle: paragraphStyle
            ]

            return NSAttributedString(string: title, attributes: attributes)

        case .attributedString(let attributedTitle):
            return attributedTitle
        }
    }

    /// Method that calculates size of view text using given max width and height arguments.
    ///
    /// - Parameters:
    ///   - maxWidth: The width constraint to apply when computing the string’s bounding rectangle.
    ///   - maxHeight: The width constraint to apply when computing the string’s bounding rectangle.
    /// - Returns: Returns the size required to draw the text.
    func size(maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude,
              maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {

        return attributedString.boundingRect(with: CGSize(width: maxWidth, height: maxHeight),
                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                             context: nil).size
    }

    /// Configures given ViewTextConfigurable instance.
    ///
    /// - Parameter view: ViewTextConfigurable instance to configure with ViewText.
    func configure(view: ViewTextConfigurable) {
        view.configure(with: self)
    }
}
