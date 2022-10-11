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

import TISwiftUtils
import TIUIElements
import TIUIKitCore
import UIKit

open class DefaultFilterTableViewCell: ContainerTableViewCell<DefaultPickerView>, ConfigurableView, Selectable {

    open var selectedStateAppearance: FilterCellStateAppearance {
        .defaultSelectedRowAppearance
    }

    open var normalStateAppearance: FilterCellStateAppearance {
        .defaultRowAppearance
    }

    open override var isSelected: Bool {
        didSet {
            let appearance = isSelected ? selectedStateAppearance : normalStateAppearance
            updateAppearance(with: appearance)
            wrappedView.setSelected(isSelected)
        }
    }

    // MARK: Life cycle

    open override func configureAppearance() {
        super.configureAppearance()

        updateAppearance(with: normalStateAppearance)
    }

    // MARK: - ConfigurableView

    open func configure(with viewModel: DefaultFilterCellViewModel) {
        wrappedView.text = viewModel.title
    }

    // MARK: - Open methods

    open func updateAppearance(with appearance: FilterCellStateAppearance) {
        contentInsets = appearance.contentInsets
        wrappedView.textColor = appearance.fontColor
        wrappedView.images = appearance.stateImages ?? [:]

        backgroundColor = appearance.backgroundColor
        layer.borderColor = appearance.borderColor.cgColor
        layer.borderWidth = appearance.borderWidth
        layer.round(corners: .allCorners, radius: appearance.cornerRadius)
    }
}

extension FilterCellStateAppearance {

    @available(iOS 13, *)
    private static let defaultStateImages: UIControl.StateImages = [.normal: nil,
                                                                    .selected: UIImage(systemName: "checkmark")]
    private static let defaultContentInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)

    static var defaultSelectedRowAppearance: FilterCellStateAppearance {
        var stateImages: UIControl.StateImages?

        if #available(iOS 13, *) {
            stateImages = defaultStateImages
        }

        return .init(borderColor: .clear,
                     backgroundColor: .white,
                     fontColor: .black,
                     borderWidth: .zero,
                     contentInsets: defaultContentInsets,
                     cornerRadius: .zero,
                     stateImages: stateImages)
    }

    static var defaultRowAppearance: FilterCellStateAppearance {
        var stateImages: UIControl.StateImages?

        if #available(iOS 13, *) {
            stateImages = defaultStateImages
        }

        return .init(borderColor: .clear,
                     backgroundColor: .white,
                     fontColor: .black,
                     borderWidth: .zero,
                     contentInsets: defaultContentInsets,
                     cornerRadius: .zero,
                     stateImages: stateImages)
    }
}
