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
import TIUIKitCore

open class BaseFilterCollectionCell: ContainerCollectionViewCell<UILabel>,
                                     ConfigurableView {

    public override var wrappedView: UILabel {
        UILabel()
    }

    public var viewModel: DefaultFilterCellViewModel?

    open var isLabelHidden: Bool {
        get {
            wrappedView.isHidden
        }
        set {
            wrappedView.isHidden = newValue
        }
    }

    open override func configureAppearance() {
        layer.round(corners: .allCorners, radius: 6)
    }

    open func configure(with viewModel: DefaultFilterCellViewModel) {
        self.viewModel = viewModel

        wrappedView.text = viewModel.title
        contentInsets = viewModel.insets

        setSelected(isSelected: viewModel.isSelected)
    }

    open func setSelected(isSelected: Bool) {
        let selectedColor = viewModel?.selectedColor ?? .green
        wrappedView.textColor = isSelected ? selectedColor : .black

        if isSelected {
            backgroundColor = viewModel?.selectedBgColor ?? .white
            layer.borderColor = selectedColor.cgColor
            layer.borderWidth = 1
        } else {
            setDeselectAppearance()
        }
    }

    open func setDeselectAppearance() {
        layer.borderWidth = 0
        backgroundColor = viewModel?.deselectedBgColor ?? .lightGray
    }
}
