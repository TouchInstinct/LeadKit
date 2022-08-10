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
                                        ConfigurableView {

    public enum SelectionState {
        case normal
        case selected
    }

    public var currentSelectionState: SelectionState {
        isSelected ? .selected : .normal
    }

    open var cellAppearance: BaseFilterCellAppearance {
        .init()
    }

    open override var isSelected: Bool {
        didSet {
            setAppearance()
        }
    }

    open override func configureAppearance() {
        super.configureAppearance()
        
        layer.round(corners: .allCorners, radius: cellAppearance.cornerRadius)
        contentInsets = cellAppearance.contentInsets

        setAppearance()
    }

    // MARK: - ConfigurableView

    open func configure(with viewModel: DefaultFilterCellViewModel) {
        wrappedView.text = viewModel.title
    }

    // MARK: - Open methdos

    open func setAppearance() {
        switch currentSelectionState {
        case .normal:
            wrappedView.textColor = cellAppearance.normalFontColor
            backgroundColor = cellAppearance.normalBgColor
            layer.borderColor = cellAppearance.normalBorderColor.cgColor
            layer.borderWidth = cellAppearance.normalBorderWidth
        case .selected:
            wrappedView.textColor = cellAppearance.selectedFontColor
            backgroundColor = cellAppearance.selectedBgColor
            layer.borderColor = cellAppearance.selectedBorderColor.cgColor
            layer.borderWidth = cellAppearance.selectedBorderWidth
        }
    }
}
