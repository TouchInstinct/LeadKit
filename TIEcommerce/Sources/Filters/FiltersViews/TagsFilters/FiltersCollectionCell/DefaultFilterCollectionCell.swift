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

open class DefaultFilterCollectionCell: ContainerCollectionViewCell<UILabel>, ConfigurableView {

    open var selectedStateAppearance: FilterCellStateAppearance {
        .defaultSelectedAppearance
    }

    open var normalStateAppearance: FilterCellStateAppearance {
        .defaultNormalAppearance
    }

    open override var isSelected: Bool {
        didSet {
            let appearance = isSelected ? selectedStateAppearance : normalStateAppearance
            updateAppearance(with: appearance)
        }
    }

    open override func configureAppearance() {
        super.configureAppearance()
        
        updateAppearance(with: normalStateAppearance)
    }

    // MARK: - ConfigurableView

    open func configure(with viewModel: DefaultFilterCellViewModel) {
        wrappedView.text = viewModel.title
    }

    // MARK: - Open methdos

    open func updateAppearance(with appearance: FilterCellStateAppearance) {
        contentInsets = appearance.contentInsets
        wrappedView.textColor = appearance.fontColor

        backgroundColor = appearance.backgroundColor
        layer.borderColor = appearance.borderColor.cgColor
        layer.borderWidth = appearance.borderWidth
        layer.round(corners: .allCorners, radius: appearance.cornerRadius)
    }
}

extension FilterCellStateAppearance {
    static var defaultSelectedAppearance: FilterCellStateAppearance {
        .init(borderColor: .systemGreen, backgroundColor: .white, fontColor: .systemGreen, borderWidth: 1)
    }

    static var defaultNormalAppearance: FilterCellStateAppearance {

        .init(borderColor: .lightGray, backgroundColor: .lightGray, fontColor: .black, borderWidth: 0)
    }
}
