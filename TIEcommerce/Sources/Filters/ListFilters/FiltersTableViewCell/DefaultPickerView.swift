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
            selectionStateImageView.heightAnchor.constraint(equalToConstant: defaultImageSize),
            selectionStateImageView.widthAnchor.constraint(equalToConstant: defaultImageSize)
        ])
    }
}
