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

import TableKit
import TIUIElements
import UIKit

open class DefaultFilterListCell: BaseSeparatorCell, ConfigurableCell {

    private var titleLeadingConstraint: NSLayoutConstraint!
    private var titleTopConstraint: NSLayoutConstraint!
    private var titleBottomConstraint: NSLayoutConstraint!

    private var imageTrailingConstraint: NSLayoutConstraint!
    private var imageTopConstraint: NSLayoutConstraint!
    private var imageBottomConstraint: NSLayoutConstraint!

    public lazy var titleLabel = UILabel()
    public lazy var selectionCheckmarkImageView = UIImageView()

    open var selectedImage: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "checkmark")!
        }

        return nil
    }

    open var deselectedImage: UIImage? {
        nil
    }

    open override func addViews() {
        super.addViews()

        contentView.addSubviews(titleLabel, selectionCheckmarkImageView)
    }

    open override func configureLayout() {
        super.configureLayout()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        selectionCheckmarkImageView.translatesAutoresizingMaskIntoConstraints = false

        titleLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        titleBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        imageTrailingConstraint = selectionCheckmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        imageTopConstraint = selectionCheckmarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        imageBottomConstraint = selectionCheckmarkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)


        NSLayoutConstraint.activate([
            titleLeadingConstraint,
            titleTopConstraint,
            titleBottomConstraint,
            imageTrailingConstraint,
            imageTopConstraint,
            imageBottomConstraint
        ])
    }

    open func configure(with viewModel: DefaultFilterRowViewModel) {
        titleLabel.text = viewModel.title

        setContentInsets(viewModel.appearance.contentInsets)
        contentView.backgroundColor = viewModel.appearance.deselectedBgColor
    }

    open func setContentInsets(_ insets: UIEdgeInsets) {
        titleLeadingConstraint.constant = insets.left
        imageTrailingConstraint.constant = -insets.right

        titleTopConstraint.constant = insets.top
        imageTopConstraint.constant = insets.top

        titleBottomConstraint.constant = -insets.bottom
        imageBottomConstraint.constant = -insets.bottom
    }

    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            selectionCheckmarkImageView.image = selectedImage
        } else {
            selectionCheckmarkImageView.image = deselectedImage
        }
    }
}
