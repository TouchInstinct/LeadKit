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

import UIKit

open class BaseFilterCellAppearance {

    public var selectedBorderColor: UIColor
    public var normalBorderColor: UIColor

    public var selectedBgColor: UIColor
    public var normalBgColor: UIColor

    public var selectedFontColor: UIColor
    public var normalFontColor: UIColor

    public var selectedBorderWidth: CGFloat
    public var normalBorderWidth: CGFloat

    public var contentInsets: UIEdgeInsets
    public var cornerRadius: CGFloat

    public init(selectedBorderColor: UIColor = .systemGreen,
                normalBorderColor: UIColor = .lightGray,
                selectedBgColor: UIColor = .white,
                normalBgColor: UIColor = .lightGray,
                selectedFontColor: UIColor = .systemGreen,
                normalFontColor: UIColor = .black,
                selectedBorderWidth: CGFloat = 1,
                normalBorderWidth: CGFloat = 0,
                contentInsets: UIEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8),
                cornerRadius: CGFloat = 6) {

        self.selectedBorderColor = selectedBorderColor
        self.normalBorderColor = normalBorderColor
        self.selectedBgColor = selectedBgColor
        self.normalBgColor = normalBgColor
        self.selectedFontColor = selectedFontColor
        self.normalFontColor = normalFontColor
        self.selectedBorderWidth = selectedBorderWidth
        self.normalBorderWidth = normalBorderWidth
        self.contentInsets = contentInsets
        self.cornerRadius = cornerRadius
    }
}
