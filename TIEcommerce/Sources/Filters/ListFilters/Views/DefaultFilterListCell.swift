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

import TIUIElements
import TIUIKitCore
import UIKit

open class DefaultPickerView: BaseInitializableView {

    private let titleLabel = UILabel()
    private let selectionStateImageView = UIImageView()

    open var image: UIImage? {
        get {
            selectionStateImageView.image
        }
        set {
            selectionStateImageView.image = newValue
        }
    }

    open var text: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    open var textColor: UIColor {
        get {
            titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
        }
    }

    open var defaultImageSize: CGFloat {
        image?.size.height ?? 0
    }

    open override func addViews() {
        super.addViews()

        addSubviews(titleLabel, selectionStateImageView)
    }

    open override func configureLayout() {
        super.configureLayout()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        selectionStateImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor),

            selectionStateImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectionStateImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectionStateImageView.heightAnchor.constraint(equalToConstant: defaultImageSize)
            selectionStateImageView.widthAnchor.constraint(equalToConstant: defaultImageSize)
        ])
    }
}

open class DefaultFilterListCell: ContainerTableViewCell<DefaultPickerView>, ConfigurableView {

    open var selectedStateAppearance: FilterCellStateAppearance {
        .defaultSelectedRowAppearance
    }

    open var normalStateAppearance: FilterCellStateAppearance {
        .defaultNormalRowAppearance
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

    open func configure(with viewModel: DefaultFilterCellViewModel) {
        wrappedView.text = viewModel.title
    }

    // MARK: - Open methods

    open func updateAppearance(with appearance: FilterCellStateAppearance) {
        contentInsets = appearance.contentInsets
        wrappedView.textColor = appearance.fontColor
        wrappedView.image = appearance.selectionImage

        backgroundColor = appearance.backgroundColor
        layer.borderColor = appearance.borderColor.cgColor
        layer.borderWidth = appearance.borderWidth
        layer.round(corners: .allCorners, radius: appearance.cornerRadius)
    }
}

extension FilterCellStateAppearance {
    static var defaultSelectedRowAppearance: FilterCellStateAppearance {
        var selectionImage: UIImage?

        if #available(iOS 13, *) {
            selectionImage = UIImage(systemName: "checkmark")
        }

        return .init(borderColor: .systemGreen,
                     backgroundColor: .white,
                     fontColor: .systemGreen,
                     borderWidth: 1,
                     selectionImage: selectionImage)
    }

    static var defaultNormalRowAppearance: FilterCellStateAppearance {

        .init(borderColor: .lightGray, backgroundColor: .lightGray, fontColor: .black, borderWidth: 0)
    }
}
