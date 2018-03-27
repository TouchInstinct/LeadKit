//
//  Copyright (c) 2018 Touch Instinct
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

import Foundation.NSAttributedString

public extension NSAttributedString {

    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: left)
        mutableAttributedString += right

        return NSAttributedString(attributedString: mutableAttributedString)
    }

    /// Mutable copy of attributed string.
    var mutable: NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }

}

public extension NSMutableAttributedString {

    static func + (left: NSMutableAttributedString, right: NSAttributedString) -> NSMutableAttributedString {
        left.append(right)

        return left
    }

    static func += (left: NSMutableAttributedString, right: NSAttributedString) {
        left.append(right)
    }

    /// Immutable copy of attributed string.
    var immutable: NSAttributedString {
        return NSAttributedString(attributedString: self)
    }

}
