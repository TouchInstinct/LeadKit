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

open class BaseFilterCollectionCell: UICollectionViewCell,
                                     SelectableCell,
                                     InitializableViewProtocol,
                                     ConfigurableView {

    public let titleLabel = UILabel()

    public var viewModel: DefaultCellViewModel?

    open var isFilterSelected: Bool = false {
        didSet {
            reloadState()
        }
    }

    open var isLabelHidden: Bool {
        get {
            titleLabel.isHidden
        }
        set {
            titleLabel.isHidden = newValue
        }
    }

    open override var intrinsicContentSize: CGSize {
        let contentSize = super.intrinsicContentSize
        let insets = viewModel?.insets ?? .zero
        let xInsets = insets.left + insets.right
        let yInsets = insets.top + insets.bottom
        return .init(width: contentSize.width + xInsets, height: contentSize.height + yInsets)
    }

    public override init(frame: CGRect) {
        super.init(frame: .zero)

        addViews()
        configureLayout()
        bindViews()
        configureAppearance()
        localize()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func addViews() {
        addSubview(titleLabel)
    }
    
    open func configureLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(titleLabel.edgesEqualToSuperview())
    }
    
    open func bindViews() {
        // override in subclass
    }

    open func configureAppearance() {
        // override in subclass
    }

    open func localize() {
        // override in subclass
    }

    open func configure(with viewModel: DefaultCellViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title

        setSelected(isSelected: viewModel.isSelected)
    }

    open func setSelected(isSelected: Bool) {
        let selectedColor = viewModel?.selectedColor ?? .green
        titleLabel.textColor = isSelected ? selectedColor : .black

        if isSelected {
            backgroundColor = .white
            layer.borderColor = selectedColor.cgColor
            layer.borderWidth = 1
        } else {
            setDeselectAppearance()
        }
    }

    open func reloadState() {
        if isFilterSelected {
            backgroundColor = .green
        } else {
            backgroundColor = .white
        }
    }

    open func setDeselectAppearance() {
        layer.borderWidth = 0
        backgroundColor = .lightGray
    }
}
