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

/// Protocol that represents text object with appearance attributes.
public protocol ViewTextConfigurable: AnyObject {

    /// Font of text object.
    var textFont: UIFont? { get set }

    /// Text color of text object.
    var titleColor: UIColor? { get set }

    /// Text alignment of text object.
    var textAlignment: NSTextAlignment { get set }

    /// Text itself of text object.
    var text: String? { get set }

    /// Attributed text of text object.
    var attributedText: NSAttributedString? { get set }
}

public extension ViewTextConfigurable {

    /// Configures text and text appearance of view using ViewText object.
    ///
    /// - Parameter viewText: ViewText object with text and text appearance.
    func configure(with viewText: ViewText) {
        switch viewText {
        case let .string(text, textAttributes):
            self.text = text
            self.configureBaseAppearance(with: textAttributes)

        case .attributedString(let attributedString):
            self.attributedText = attributedString
        }
    }

    /// Configures text appearance of view.
    ///
    /// - Parameter baseTextAttributes: Set of attributes to configure appearance of text.
    func configureBaseAppearance(with baseTextAttributes: BaseTextAttributes) {
        textFont = baseTextAttributes.font
        titleColor = baseTextAttributes.color
        textAlignment = baseTextAttributes.alignment
    }
}
