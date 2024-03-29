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

import TIUIKitCore
import UIKit

public struct FilterCellStateAppearance {

    public let borderColor: UIColor
    public let backgroundColor: UIColor
    public let fontColor: UIColor

    public let borderWidth: CGFloat
    public let contentInsets: UIEdgeInsets
    public let cornerRadius: CGFloat

    public let stateImages: UIControl.StateImages?

    public init(borderColor: UIColor,
                backgroundColor: UIColor,
                fontColor: UIColor,
                borderWidth: CGFloat,
                contentInsets: UIEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8),
                cornerRadius: CGFloat = 6,
                stateImages: UIControl.StateImages? = nil) {

        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.fontColor = fontColor
        self.borderWidth = borderWidth
        self.contentInsets = contentInsets
        self.cornerRadius = cornerRadius
        self.stateImages = stateImages
    }
}
