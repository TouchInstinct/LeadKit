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

import UIKit.UIButton

extension UIButton: ViewTextConfigurable {

    public var textFont: UIFont? {
        get {
            return titleLabel?.font
        }
        set {
            titleLabel?.font = newValue
        }
    }

    public var titleColor: UIColor? {
        get {
            return currentTitleColor
        }
        set {
            setTitleColor(newValue, for: [])
        }
    }

    public var textAlignment: NSTextAlignment {
        get {
            return contentHorizontalAlignment.textAlignment
        }
        set {
            contentHorizontalAlignment = .init(textAlignment: newValue)
        }
    }

    public var text: String? {
        get {
            return currentTitle
        }
        set {
            setTitle(newValue, for: [])
        }
    }

    public var attributedText: NSAttributedString? {
        get {
            return currentAttributedTitle
        }
        set {
            setAttributedTitle(newValue, for: [])
        }
    }
}

private extension UIControl.ContentHorizontalAlignment {

    init(textAlignment: NSTextAlignment) {
        switch textAlignment {
        case .left:
            self = .leading

        case .right:
            self = .trailing

        case .center:
            self = .center

        case .justified:
            self = .fill

        case .natural:
            self = .leading

        @unknown default:
            self = .leading
        }
    }

    var textAlignment: NSTextAlignment {
        switch self {
        case .left:
            return .left

        case .right:
            return .right

        case .center:
            return .center

        case .fill:
            return .justified

        case .leading:
            return .natural

        case .trailing:
            return .right

        @unknown default:
            return .natural
        }
    }
}
