//
//  Copyright (c) 2017 Touch Instinct
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
import TableKit

private enum Constants {
    static let defaultSeparatorHeight = CGFloat(pixels: 1)
}

/// Base cell that provides separator support
/// Take note that:
/// - in `configure(with:)` you must call `configureSeparator(with:)`
/// - separators are simple views, that located on `contentView`.
/// - if you hide that with another view that fully hide you can use that method `moveSeparators(to:)`
open class SeparatorCell: UITableViewCell {

    // MARK: - Public

    /// Configure separator with viewModel
    /// - parameter separatorType: type of separators
    public func configureSeparator(with separatorType: CellSeparatorType) {
        switch separatorType {
        case .none:
            topView.isHidden = true
            bottomView.isHidden = true
        case .bottom(let configuration):
            topView.isHidden = true
            bottomView.isHidden = false
            updateBottomSeparator(with: configuration)
        case .top(let configuration):
            topView.isHidden = false
            bottomView.isHidden = true
            updateTopSeparator(with: configuration)
        case .full(let topConfiguration, let bottomConfiguration):
            topView.isHidden = false
            bottomView.isHidden = false
            updateTopSeparator(with: topConfiguration)
            updateBottomSeparator(with: bottomConfiguration)
        }
    }

    /// Move separator upward in hierarchy
    public func bringSeparatorsToFront() {
        contentView.bringSubview(toFront: topView)
        contentView.bringSubview(toFront: bottomView)
    }

    /// Move separator backward in hierarchy
    public func sendSeparatorsToBack() {
        contentView.sendSubview(toBack: topView)
        contentView.sendSubview(toBack: bottomView)
    }

    // MARK: - Private

    private var topView: UIView!
    private var bottomView: UIView!

    // top separator constraints
    private var topViewLeftConstraint: NSLayoutConstraint!
    private var topViewRightConstraint: NSLayoutConstraint!
    private var topViewTopConstraint: NSLayoutConstraint!
    private var topViewHeightConstraint: NSLayoutConstraint!

    // bottom separator constraints
    private var bottomViewLeftConstraint: NSLayoutConstraint!
    private var bottomViewRightConstraint: NSLayoutConstraint!
    private var bottomViewBottomConstraint: NSLayoutConstraint!
    private var bottomViewHeightConstraint: NSLayoutConstraint!

    private var topSeparatorInsets    = UIEdgeInsets.zero
    private var bottomSeparatorInsets = UIEdgeInsets.zero

    private var topSeparatorHeight    = Constants.defaultSeparatorHeight
    private var bottomSeparatorHeight = Constants.defaultSeparatorHeight

    // MARK: - Initialization

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureLineViews()
    }

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureLineViews()
    }

    override open func updateConstraints() {
        topViewTopConstraint.constant       = topSeparatorInsets.top
        topViewLeftConstraint.constant      = topSeparatorInsets.left
        topViewRightConstraint.constant     = topSeparatorInsets.right
        topViewHeightConstraint.constant    = topSeparatorHeight

        bottomViewLeftConstraint.constant   = bottomSeparatorInsets.left
        bottomViewRightConstraint.constant  = bottomSeparatorInsets.right
        bottomViewBottomConstraint.constant = bottomSeparatorInsets.bottom
        bottomViewHeightConstraint.constant = bottomSeparatorHeight

        super.updateConstraints()
    }

    // MARK: - Private

    private func configureLineViews() {
        topView = createSeparatorView()
        bottomView = createSeparatorView()

        createConstraints()
    }

    private func createSeparatorView() -> UIView {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }

    private func updateTopSeparator(with configuration: SeparatorConfiguration) {
        topView.backgroundColor = configuration.color
        topSeparatorHeight = configuration.height
        topSeparatorInsets = configuration.insets ?? .zero
    }

    private func updateBottomSeparator(with configuration: SeparatorConfiguration) {
        bottomView.backgroundColor = configuration.color
        bottomSeparatorHeight      = configuration.height
        bottomSeparatorInsets      = configuration.insets ?? .zero
    }

    private func createConstraints() {
        // height
        topViewHeightConstraint = topView.heightAnchor.constraint(equalToConstant: topSeparatorHeight)
        topViewHeightConstraint.isActive = true

        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: bottomSeparatorHeight)
        bottomViewHeightConstraint.isActive = true

        // top separator
        topViewTopConstraint = topView.topAnchor.constraint(equalTo: contentView.topAnchor)
        topViewTopConstraint.isActive = true

        topViewRightConstraint = contentView.rightAnchor.constraint(equalTo: topView.rightAnchor)
        topViewRightConstraint.isActive = true

        topViewLeftConstraint = topView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        topViewLeftConstraint.isActive = true

        // bottom separator
        bottomViewRightConstraint = contentView.rightAnchor.constraint(equalTo: bottomView.rightAnchor)
        bottomViewRightConstraint.isActive = true

        bottomViewLeftConstraint = bottomView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        bottomViewLeftConstraint.isActive = true

        bottomViewBottomConstraint = bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomViewBottomConstraint.isActive = true
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        configureSeparator(with: .none)
    }

}
