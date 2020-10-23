//
//  Copyright (c) 2020 Touch Instinct
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

open class BaseSeparatorCell: BaseInitializableCell, SeparatorConfigurable {
    private lazy var topSeparatorView = createTopSeparator()
    private lazy var bottomSeparatorView = UIView()

    private var topViewLeftConstraint: NSLayoutConstraint?
    private var topViewRightConstraint: NSLayoutConstraint?
    private var topViewTopConstraint: NSLayoutConstraint?
    private var topViewHeightConstraint: NSLayoutConstraint?

    private var bottomViewLeftConstraint: NSLayoutConstraint?
    private var bottomViewRightConstraint: NSLayoutConstraint?
    private var bottomViewBottomConstraint: NSLayoutConstraint?
    private var bottomViewHeightConstraint: NSLayoutConstraint?

    open func createTopSeparator() -> UIView {
        .init()
    }

    open func createBottomSeparator() -> UIView {
        .init()
    }

    open func add(topSeparatorView: UIView) {
        contentView.addSubview(topSeparatorView)
    }

    open func add(bottomSeparatorView: UIView) {
        contentView.addSubview(bottomSeparatorView)
    }

    public func configureSeparators(with separatorType: ViewSeparatorType) {
        topSeparatorView.isHidden = separatorType.topIsHidden
        bottomSeparatorView.isHidden = separatorType.bottomIsHidden

        switch separatorType {
        case .none:
            break

        case let .bottom(configuration):
            updateBottomSeparator(with: configuration)

        case let .top(configuration):
            updateTopSeparator(with: configuration)

        case let .full(topConfiguration, bottomConfiguration):
            updateTopSeparator(with: topConfiguration)
            updateBottomSeparator(with: bottomConfiguration)
        }
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        configureSeparators(with: .none)
    }

    // MARK: - InitializableView

    open override func addViews() {
        super.addViews()

        add(topSeparatorView: topSeparatorView)
        add(bottomSeparatorView: bottomSeparatorView)
    }

    open override func configureLayout() {
        super.configureLayout()

        if let separatorSuperview = topSeparatorView.superview {
            topViewTopConstraint = topSeparatorView.topAnchor.constraint(equalTo: separatorSuperview.topAnchor)
            topViewRightConstraint = separatorSuperview.rightAnchor.constraint(equalTo: topSeparatorView.rightAnchor)
            topViewLeftConstraint = topSeparatorView.leftAnchor.constraint(equalTo: separatorSuperview.leftAnchor)
        }

        topViewHeightConstraint = topSeparatorView.heightAnchor.constraint(equalToConstant: 1)

        if let separatorSuperview = topSeparatorView.superview {
            bottomViewRightConstraint = separatorSuperview.rightAnchor.constraint(equalTo: bottomSeparatorView.rightAnchor)
            bottomViewLeftConstraint = bottomSeparatorView.leftAnchor.constraint(equalTo: separatorSuperview.leftAnchor)
            bottomViewBottomConstraint = bottomSeparatorView.bottomAnchor.constraint(equalTo: separatorSuperview.bottomAnchor)
        }

        bottomViewHeightConstraint = bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1)

        NSLayoutConstraint.activate([
            topViewTopConstraint,
            topViewRightConstraint,
            topViewLeftConstraint,
            topViewHeightConstraint,
            bottomViewRightConstraint,
            bottomViewLeftConstraint,
            bottomViewBottomConstraint,
            bottomViewHeightConstraint
        ].compactMap { $0 })
    }

    open override func configureAppearance() {
        super.configureAppearance()

        [topSeparatorView, bottomSeparatorView].forEach {
            $0.isHidden = true
            $0.backgroundColor = .black
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

private extension BaseSeparatorCell {
    func updateTopSeparator(with configuration: SeparatorConfiguration) {
        topSeparatorView.backgroundColor = configuration.color
        topViewHeightConstraint?.constant = configuration.height
        topViewTopConstraint?.constant = configuration.insets.top
        topViewLeftConstraint?.constant = configuration.insets.left
        topViewRightConstraint?.constant = -configuration.insets.right
    }

    func updateBottomSeparator(with configuration: SeparatorConfiguration) {
        bottomSeparatorView.backgroundColor = configuration.color
        bottomViewHeightConstraint?.constant = configuration.height
        bottomViewBottomConstraint?.constant = -configuration.insets.bottom
        bottomViewLeftConstraint?.constant = configuration.insets.left
        bottomViewRightConstraint?.constant = -configuration.insets.right
    }
}
