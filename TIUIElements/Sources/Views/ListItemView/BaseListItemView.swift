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

open class BaseListItemView<LeadingView: UIView,
                            MiddleView: UIView,
                            TrailingView: UIView>: BaseInitializableView {

    public let leadingView = LeadingView()
    public let middleView = MiddleView()
    public let trailingView = TrailingView()

    // MARK: - Constraints

    public var leadingViewLeadingToSuperviewConstraint: NSLayoutConstraint?
    public var leadingViewTopConstraint: NSLayoutConstraint?
    public var leadingViewBottomConstraint: NSLayoutConstraint?
    public var leadingViewCenterYConstraint: NSLayoutConstraint?
    public var leadingViewWidthConstraint: NSLayoutConstraint?
    public var leadingViewHeightConstraint: NSLayoutConstraint?

    public var middleViewLeadingToSuperViewConstraint: NSLayoutConstraint?
    public var middleViewLeadingConstraint: NSLayoutConstraint?
    public var middleViewTopConstraint: NSLayoutConstraint?
    public var middleViewTrailingToSuperViewConstraint: NSLayoutConstraint?
    public var middleViewBottomConstraint: NSLayoutConstraint?
    public var middleViewCenterYConstraint: NSLayoutConstraint?
    public var middleViewWidthConstraint: NSLayoutConstraint?
    public var middleViewHeightConstraint: NSLayoutConstraint?

    public var trailingViewLeadingToMiddleViewConstraint: NSLayoutConstraint?
    public var trailingViewTopConstraint: NSLayoutConstraint?
    public var trailingViewTrailingToSuperviewConstraint: NSLayoutConstraint?
    public var trailingViewBottomConstraint: NSLayoutConstraint?
    public var trailingViewCenterYConstraint: NSLayoutConstraint?
    public var trailingViewWidthConstraint: NSLayoutConstraint?
    public var trailingViewHeightConstraint: NSLayoutConstraint?

    // MARK: - Public Properties

    public var leadingViewConstraints: [NSLayoutConstraint?] {
        [
            leadingViewLeadingToSuperviewConstraint,
            leadingViewTopConstraint,
            leadingViewBottomConstraint,
            leadingViewCenterYConstraint,
            leadingViewHeightConstraint,
            leadingViewWidthConstraint
        ]
    }

    public var trailingViewConstraints: [NSLayoutConstraint?] {
        [
            trailingViewLeadingToMiddleViewConstraint,
            trailingViewTopConstraint,
            trailingViewBottomConstraint,
            trailingViewTrailingToSuperviewConstraint,
            trailingViewCenterYConstraint,
            trailingViewHeightConstraint,
            trailingViewWidthConstraint,
        ]
    }

    open var isLeadingViewHidden: Bool {
        leadingView.isHidden
    }

    open var isTrailingViewHidden: Bool {
        trailingView.isHidden
    }

    // MARK: - BaseInitializableView

    open override func addViews() {
        super.addViews()

        addSubviews(leadingView, middleView, trailingView)
    }

    open override func configureLayout() {
        super.configureLayout()

        [leadingView, middleView, trailingView]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        leadingViewLeadingToSuperviewConstraint = leadingView.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingViewTopConstraint = leadingView.topAnchor.constraint(equalTo: topAnchor)
        leadingViewBottomConstraint = leadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        leadingViewCenterYConstraint = leadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        leadingViewWidthConstraint = leadingView.widthAnchor.constraint(equalToConstant: .zero)
        leadingViewHeightConstraint = leadingView.heightAnchor.constraint(equalToConstant: .zero)

        middleViewLeadingToSuperViewConstraint = middleView.leadingAnchor.constraint(equalTo: leadingAnchor)
        middleViewLeadingConstraint = middleView.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor)
        middleViewCenterYConstraint = middleView.centerYAnchor.constraint(equalTo: centerYAnchor)
        middleViewTopConstraint = middleView.topAnchor.constraint(equalTo: topAnchor)
        middleViewTrailingToSuperViewConstraint = middleView.trailingAnchor.constraint(equalTo: trailingAnchor)
        middleViewBottomConstraint = middleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        middleViewWidthConstraint = middleView.widthAnchor.constraint(equalToConstant: .zero)
        middleViewHeightConstraint = middleView.heightAnchor.constraint(equalToConstant: .zero)

        trailingViewLeadingToMiddleViewConstraint = trailingView.leadingAnchor.constraint(equalTo: middleView.trailingAnchor)
        trailingViewTopConstraint = trailingView.topAnchor.constraint(equalTo: topAnchor)
        trailingViewTrailingToSuperviewConstraint = trailingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        trailingViewBottomConstraint = trailingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        trailingViewCenterYConstraint = trailingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        trailingViewWidthConstraint = trailingView.widthAnchor.constraint(equalToConstant: .zero)
        trailingViewHeightConstraint = trailingView.heightAnchor.constraint(equalToConstant: .zero)

        NSLayoutConstraint.activate([
            leadingViewLeadingToSuperviewConstraint,
            leadingViewTopConstraint,
            leadingViewBottomConstraint,

            middleViewLeadingConstraint,

            trailingViewTopConstraint,
            trailingViewBottomConstraint,
            trailingViewLeadingToMiddleViewConstraint,
            trailingViewTrailingToSuperviewConstraint,
        ].compactMap { $0 })

        NSLayoutConstraint.deactivate([
            leadingViewCenterYConstraint,
            leadingViewWidthConstraint,
            leadingViewHeightConstraint,

            middleViewLeadingToSuperViewConstraint,
            middleViewTopConstraint,
            middleViewTrailingToSuperViewConstraint,
            middleViewBottomConstraint,
            middleViewCenterYConstraint,
            middleViewWidthConstraint,
            middleViewHeightConstraint,

            trailingViewCenterYConstraint,
            trailingViewHeightConstraint,
            trailingViewWidthConstraint,
        ].compactMap { $0 })
    }

    // MARK: - Public methods

    public func configureBaseListItem(appearance: BaseListItemAppearance<some WrappedViewAppearance,
                                                                         some WrappedViewAppearance,
                                                                         some WrappedViewAppearance>) {

        configureUIView(appearance: appearance)

        updateLeadingViewLayout(leadingViewLayout: appearance.leadingViewAppearance.layout,
                                middleViewLayout: appearance.middleViewAppearance.layout)

        updateMiddleViewLayout(containerLayout: appearance.layout,
                               middleViewLayout: appearance.middleViewAppearance.layout)

        updateTrailingViewLayout(trailingViewLayout: appearance.trailingAppearance.layout,
                                 middleViewLayout: appearance.middleViewAppearance.layout)
    }

    // MARK: - Private methdos

    private func updateLeadingViewLayout(leadingViewLayout: WrappedViewLayout,
                                         middleViewLayout: WrappedViewLayout) {

        let leadingToSuperviewContraint: NSLayoutConstraint?
        let leadingViewLeftInset: CGFloat

        if isLeadingViewHidden {
            hideView(leadingViewConstraints)
            middleViewLeadingToSuperViewConstraint?.isActive = true

            leadingToSuperviewContraint = middleViewLeadingToSuperViewConstraint
            leadingViewLeftInset = middleViewLayout.insets.left

        } else {
            middleViewLeadingConstraint?.constant = leadingViewLayout.insets.right + middleViewLayout.insets.left
            leadingViewLeadingToSuperviewConstraint?.isActive = true
            middleViewLeadingConstraint?.isActive = true
            middleViewLeadingToSuperViewConstraint?.isActive = false

            setupCenterYOffset(layout: leadingViewLayout,
                               centerYConstraint: leadingViewCenterYConstraint,
                               topConstraint: leadingViewTopConstraint,
                               bottomContraint: leadingViewBottomConstraint)

            setupSize(width: leadingViewLayout.size.width,
                      height: leadingViewLayout.size.height,
                      widthConstraint: leadingViewWidthConstraint,
                      heightConstraint: leadingViewHeightConstraint)

            leadingToSuperviewContraint = leadingViewLeadingToSuperviewConstraint
            leadingViewLeftInset = leadingViewLayout.insets.left
        }

        leadingToSuperviewContraint?.constant = leadingViewLeftInset
    }

    private func updateMiddleViewLayout(containerLayout: ViewLayout,
                                        middleViewLayout: WrappedViewLayout) {

        setupCenterYOffset(layout: middleViewLayout,
                           centerYConstraint: middleViewCenterYConstraint,
                           topConstraint: middleViewTopConstraint,
                           bottomContraint: middleViewBottomConstraint)

        setupSize(width: middleViewLayout.size.width,
                  height: middleViewLayout.size.height,
                  widthConstraint: middleViewWidthConstraint,
                  heightConstraint: middleViewHeightConstraint)
    }

    private func updateTrailingViewLayout(trailingViewLayout: WrappedViewLayout,
                                          middleViewLayout: WrappedViewLayout) {

        let trailingToSuperviewConstraint: NSLayoutConstraint?
        let trailingViewRightInset: CGFloat

        if isTrailingViewHidden {
            hideView(trailingViewConstraints)
            middleViewTrailingToSuperViewConstraint?.isActive = true

            trailingToSuperviewConstraint = middleViewTrailingToSuperViewConstraint
            trailingViewRightInset = middleViewLayout.insets.right

        } else {
            trailingViewLeadingToMiddleViewConstraint?.constant = middleViewLayout.insets.right + trailingViewLayout.insets.left
            trailingViewLeadingToMiddleViewConstraint?.isActive = true
            middleViewTrailingToSuperViewConstraint?.isActive = false

            setupCenterYOffset(layout: trailingViewLayout,
                               centerYConstraint: trailingViewCenterYConstraint,
                               topConstraint: trailingViewTopConstraint,
                               bottomContraint: trailingViewBottomConstraint)

            setupSize(width: trailingViewLayout.size.width,
                      height: trailingViewLayout.size.height,
                      widthConstraint: trailingViewWidthConstraint,
                      heightConstraint: trailingViewWidthConstraint)

            trailingToSuperviewConstraint = trailingViewTrailingToSuperviewConstraint
            trailingViewRightInset = trailingViewLayout.insets.right
        }

        trailingToSuperviewConstraint?.constant = -trailingViewRightInset
    }

    private func hideView(_ constraints: [NSLayoutConstraint?]) {
        NSLayoutConstraint.deactivate(constraints.compactMap { $0 })
    }

    private func setupCenterYOffset(layout: WrappedViewLayout,
                                    centerYConstraint: NSLayoutConstraint?,
                                    topConstraint: NSLayoutConstraint?,
                                    bottomContraint: NSLayoutConstraint?) {

        let centerYOffset = layout.centerOffset.vertical

        if centerYOffset.isFinite {
            centerYConstraint?.constant = centerYOffset
            centerYConstraint?.isActive = true
            topConstraint?.isActive = false
            bottomContraint?.isActive = false
        } else {
            topConstraint?.constant = layout.insets.top
            bottomContraint?.constant = -layout.insets.bottom
            centerYConstraint?.isActive = false
            topConstraint?.isActive = true
            bottomContraint?.isActive = true
        }
    }

    private func setupSize(width: CGFloat,
                           height: CGFloat,
                           widthConstraint: NSLayoutConstraint?,
                           heightConstraint: NSLayoutConstraint?) {

        if width.isFinite {
            widthConstraint?.constant = width
            widthConstraint?.isActive = true
        } else {
            widthConstraint?.isActive = false
        }

        if height.isFinite {
            heightConstraint?.constant = height
            heightConstraint?.isActive = true
        } else {
            heightConstraint?.isActive = false
        }
    }
}
