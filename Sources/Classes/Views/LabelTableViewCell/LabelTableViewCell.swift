//
//  Copyright (c) 2019 Touch Instinct
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
import SnapKit

/// Label cell with separators, includes background image view.
open class LabelTableViewCell: SeparatorCell, InitializableView, ConfigurableCell {

    // MARK: - Properties

    private let label = UILabel()
    private let backgroundImageView = UIImageView()
    private let contentContainerView = UIView()

    private var viewModel: LabelCellViewModel?

    // MARK: - Init

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    open override func updateConstraints() {
        let topSeparatorHeight = viewModel?.separatorType.topConfiguration?.totalHeight ?? 0
        let bottomSeparatorHeight = viewModel?.separatorType.bottomConfiguration?.totalHeight ?? 0

        contentContainerView.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(contentInsets.top + topSeparatorHeight)
            make.leading.equalToSuperview().inset(contentInsets.left)
            make.trailing.equalToSuperview().inset(contentInsets.right)
            make.bottom.equalToSuperview().inset(contentInsets.bottom + bottomSeparatorHeight)
        }

        label.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(labelInsets)
        }

        backgroundImageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        super.updateConstraints()
    }

    // MARK: - InitializableView

    open func addViews() {
        contentView.addSubview(contentContainerView)
        contentContainerView.addSubviews(backgroundImageView, label)
    }

    open func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear

        contentView.backgroundColor = .clear

        configureAppearance(of: label, backgroundImageView: backgroundImageView)
    }

    // MARK: - ConfigurableCell

    public func configure(with viewModel: LabelCellViewModel) {
        configureLabelCell(with: viewModel)
    }

    // MARK: - Private

    private var labelInsets: UIEdgeInsets {
        return viewModel?.labelInsets ?? .zero
    }

    private var contentInsets: UIEdgeInsets {
        return viewModel?.contentInsets ?? .zero
    }

    // MARK: - Subclass methods to override

    /// Callback for label and background image view appearance configuration.
    ///
    /// - Parameters:
    ///   - label: Internal UILabel instance to configure.
    ///   - backgroundImageView: Internal UIImageView instance to configure.
    open func configureAppearance(of label: UILabel, backgroundImageView: UIImageView) {
        label.numberOfLines = 0
    }

    // MARK: - Configuration methods

    /// Convenient method for configuration cell with LabelCellViewModel.
    ///
    /// - Parameter viewModel: LabelCellViewModel instance.
    public func configureLabelCell(with viewModel: LabelCellViewModel) {
        self.viewModel = viewModel

        configureSeparator(with: viewModel.separatorType)
        configureLabelText(with: viewModel.viewText)
        configureContentBackground(with: viewModel.contentBackground)

        setNeedsUpdateConstraints()
    }

    /// Method for background configuration.
    ///
    /// - Parameter contentBackground: Content background to use as background.
    public func configureContentBackground(with contentBackground: ViewBackground) {
        contentBackground.configure(backgroundView: contentContainerView,
                                    backgroundImageView: backgroundImageView)
    }

    /// Method for text configuration.
    ///
    /// - Parameter viewText: View text to use as background.
    public func configureLabelText(with viewText: ViewText) {
        label.configure(with: viewText)
    }
}
