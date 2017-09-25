//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

/**
 *  Struct for holding result of string size calculation
 */
public struct StringSizeCalculationResult {

    public let size: CGSize
    public let fontLineHeight: CGFloat?

}

public extension StringSizeCalculationResult {

    public var height: CGFloat { return size.height }

    public var width: CGFloat { return size.width }

    public var numberOfLines: UInt? {
        if let lineHeight = fontLineHeight {
            let lineHeightRounded = Double(lineHeight).roundValue(withPersicion: 2)

            let heightRounded = Double(height).roundValue(withPersicion: 2)

            let numberOfLines = ceil(heightRounded / lineHeightRounded)

            return UInt(numberOfLines)
        }

        return nil
    }

}

public extension String {

    /**
     method which calculates string size based on given character attributes and (optional) max width and height

     - parameter attributes: dictionary with string character attributes
     - parameter maxWidth:   maximum width of text
     - parameter maxHeight:  maximum height of text

     - returns: string size calculation result
     */
    public func size(withAttributes attributes: [NSAttributedStringKey: Any]?,
                     maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude,
                     maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude) -> StringSizeCalculationResult {

        let size = self.boundingRect(with: CGSize(width: maxWidth, height: maxHeight),
                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                             attributes: attributes,
                                             context: nil).size

        let fontLineHeight = (attributes?[NSAttributedStringKey.font] as? UIFont)?.lineHeight

        return StringSizeCalculationResult(size: size, fontLineHeight: fontLineHeight)
    }

}
