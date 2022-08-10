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
    /// The color of the border in selected state
    public var selectedColor: UIColor
    /// The color of the background in the selected state
    public var selectedBgColor: UIColor
    /// The color of the background in the deselected state
    public var deselectedBgColor: UIColor
    public var selectedFontColor: UIColor
    public var deselectedFontColor: UIColor
    public var contentInsets: UIEdgeInsets
    public var cornerRadius: CGFloat

    public init(selectedColor: UIColor,
                selectedBgColor: UIColor,
                deselectedBgColor: UIColor,
                selectedFontColor: UIColor,
                deselectedFontColor: UIColor,
                contentInsets: UIEdgeInsets,
                cornerRadius: CGFloat) {

        self.selectedColor = selectedColor
        self.selectedBgColor = selectedBgColor
        self.deselectedBgColor = deselectedBgColor
        self.selectedFontColor = selectedFontColor
        self.deselectedFontColor = deselectedFontColor
        self.contentInsets = contentInsets
        self.cornerRadius = cornerRadius
    }
}

// MARK: - Default appearance

public extension BaseFilterCellAppearance {
    static var defaultFilterCellAppearance: BaseFilterCellAppearance {
        .init(selectedColor: .systemGreen,
              selectedBgColor: .white,
              deselectedBgColor: .lightGray,
              selectedFontColor: .systemGreen,
              deselectedFontColor: .black,
              contentInsets: .init(top: 4, left: 8, bottom: 4, right: 8),
              cornerRadius: 6)
    }
}
