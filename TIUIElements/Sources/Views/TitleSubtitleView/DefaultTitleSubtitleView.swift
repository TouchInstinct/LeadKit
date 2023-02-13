//
//  Copyright (c) 2023 Touch Instinct
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
import UIKit

public final class DefaultTitleSubtitleView: BaseInitializableView,
                                             ConfigurableView,
                                             AppearanceConfigurable {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    public var titleLableBottomConstraint: NSLayoutConstraint?
    public var spacingConstraint: NSLayoutConstraint?

    // MARK: - InitializableViewProtocol

    public override func addViews() {
        super.addViews()

        addSubviews(titleLabel, subtitleLabel)
    }

    public override func configureLayout() {
        super.configureLayout()

        [titleLabel, subtitleLabel]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        titleLableBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        spacingConstraint = subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            spacingConstraint,
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ].compactMap { $0 })
    }

    // MARK: - ConfigurableView

    public func configure(with viewModel: DefaultTitleSubtitleViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle

        setSubtitle(hidden: viewModel.isSubtitleHidden)
    }

    // MARK: - Public methods

    public func setSubtitle(hidden: Bool) {
        subtitleLabel.isHidden = hidden
        spacingConstraint?.isActive = !hidden
        titleLableBottomConstraint?.isActive = hidden
    }

    // MARK: - AppearanceConfigurable

    public func configure(appearance: Appearance) {
        configureUIView(appearance: appearance)
        titleLabel.configureUILabel(appearance: appearance.titleAppearance)
        subtitleLabel.configureUILabel(appearance: appearance.subtitleAppearance)

        configure(layout: appearance.layout)
    }

    public func configure(layout: Layout) {
        spacingConstraint?.constant = layout.spacing
    }
}
