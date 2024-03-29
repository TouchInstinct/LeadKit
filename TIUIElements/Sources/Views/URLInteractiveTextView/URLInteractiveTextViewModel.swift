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

import TISwiftUtils
import TIUIKitCore
import UIKit.UITextView

open class URLInteractiveTextViewModel {
    public var text: String
    public var primaryTextStyle: BaseTextAttributes
    public var interactiveParts: [UITextView.InteractivePart]
    public var interactivePartsStyle: BaseTextAttributes
    public var interactionHandler: UITextViewURLInteractionHandler?

    public init(text: String,
                primaryTextStyle: BaseTextAttributes,
                interactiveParts: [UITextView.InteractivePart],
                interactivePartsStyle: BaseTextAttributes,
                interactionHandler: UITextViewURLInteractionHandler?) {

        self.text = text
        self.primaryTextStyle = primaryTextStyle
        self.interactiveParts = interactiveParts
        self.interactivePartsStyle = interactivePartsStyle
        self.interactionHandler = interactionHandler
    }

    convenience init(text: String,
                     primaryTextStyle: BaseTextAttributes,
                     interactiveParts: [UITextView.InteractivePart],
                     interactivePartsStyle: BaseTextAttributes,
                     urlInteractionHandler: ParameterClosure<URL>?) {

        self.init(text: text,
                  primaryTextStyle: primaryTextStyle,
                  interactiveParts: interactiveParts,
                  interactivePartsStyle: interactivePartsStyle,
                  interactionHandler: DefaultUITextViewURLInteractionHandler(urlInteractionHandler: urlInteractionHandler))
    }
}
