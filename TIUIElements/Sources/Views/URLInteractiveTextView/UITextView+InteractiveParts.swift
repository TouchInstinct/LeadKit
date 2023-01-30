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

import UIKit.UITextView
import TIUIKitCore

public extension UITextView {
    private typealias InteractiveRange = (range: Range<String.Index>, url: URL)

    struct InteractivePart {
        public let text: String
        public let url: URL?

        public init(text: String, url: URL?) {
            self.text = text
            self.url = url
        }
    }

    func set(text: String,
             primaryTextStyle: BaseTextAttributes,
             interactiveParts: [InteractivePart],
             interactivePartsStyle: BaseTextAttributes) {

        let mutableAttributedText = NSMutableAttributedString(string: text, attributes: primaryTextStyle.attributedStringAttributes)

        let interactiveAttributes = interactivePartsStyle.attributedStringAttributes

        interactiveParts
            .compactMap { interactivePart -> InteractiveRange? in
                guard let range = text.range(of: interactivePart.text),
                      let url = interactivePart.url else {

                    return nil
                }

                return InteractiveRange(range: range, url: url)
            }
            .forEach { range, url in
                var partLinkAttributes = interactiveAttributes
                partLinkAttributes.updateValue(url, forKey: .link)

                mutableAttributedText.addAttributes(partLinkAttributes, range: NSRange(range, in: text))
            }

        attributedText = mutableAttributedText
    }
}
