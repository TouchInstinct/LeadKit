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
import TIUIElements
import UIKit

open class DefaultFilterCollectionCell: ContainerCollectionViewCell<UILabel>,
                                        ReuseIdentifierProtocol,
                                        ConfigurableView {

    open class var reuseIdentifier: String {
        "default-filter-cell"
    }

    open var cellAppearance: BaseFilterCellAppearance {
        .defaultFilterCellAppearance
    }

    open override var isSelected: Bool {
        didSet {
            isSelected ? setSelectedAppearance() : setDeselectAppearance()
        }
    }

    open override func configureAppearance() {
        super.configureAppearance()
        
        layer.round(corners: .allCorners, radius: cellAppearance.cornerRadius)
        contentInsets = cellAppearance.contentInsets

        setDeselectAppearance()
    }

    // MARK: - ConfigurableView

    open func configure(with viewModel: DefaultFilterCellViewModel) {
        wrappedView.text = viewModel.title
    }

    open func setSelectedAppearance() {
        wrappedView.textColor = cellAppearance.selectedFontColor
        backgroundColor = cellAppearance.selectedBgColor
        layer.borderColor = cellAppearance.selectedColor.cgColor
        layer.borderWidth = 1
    }

    open func setDeselectAppearance() {
        wrappedView.textColor = cellAppearance.deselectedFontColor
        layer.borderWidth = 0
        backgroundColor = cellAppearance.deselectedBgColor
    }
}
