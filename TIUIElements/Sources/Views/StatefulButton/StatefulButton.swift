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

import TISwiftUtils
import TIUIKitCore
import UIKit

open class StatefulButton: UIButton {

    public enum ActivityIndicatorPosition {
        case center
        case before(view: UIView, offset: CGFloat)
        case after(view: UIView, offset: CGFloat)

        var offset: CGFloat {
            switch self {
            case .center:
                return .zero

            case let .before(_, offset), let .after(_, offset):
                return offset
            }
        }
    }

    public typealias StateEventPropagations = [State: Bool]

    private var activityIndicator: ActivityIndicator? {
        willSet {
            activityIndicator?.removeFromSuperview()
        }
        didSet {
            if let activityIndicator = activityIndicator {
                addSubview(activityIndicator)
            }
        }
    }

    public var isLoading = false {
        didSet {
            isLoading
                ? activityIndicator?.startAnimating()
                : activityIndicator?.stopAnimating()

            isEnabled = !isLoading
        }
    }

    public var additionalHitTestMargins: UIEdgeInsets = .zero

    public var onDisabledStateTapHandler: VoidClosure?

    var eventPropagations: StateEventPropagations = [:]

    // MARK: - Background

    private var backgroundColors: StateColors = [:] {
        didSet {
            updateBackgroundColor()
        }
    }

    public func set(backgroundColors: StateColors) {
        backgroundColors.forEach { setBackgroundColor($1, for: $0) }
    }

    public func setBackgroundColor(_ color: UIColor?, for state: State) {
        backgroundColors[state] = color
    }

    public func backgroundColor(for state: State) -> UIColor? {
        // Value of optional type 'UIColor??' must be unwrapped to a value of type 'UIColor?'
        // 🤷 Swift 5.3 (Xcode 12.2)
        backgroundColors[state] ?? nil //swiftlint:disable:this redundant_nil_coalescing
    }

    public func setEventPropagation(_ eventPropagation: Bool, for state: State) {
        eventPropagations[state] = eventPropagation
    }

    // MARK: - UIControl override

    override open var isEnabled: Bool {
        didSet {
            updateBackgroundColor()
        }
    }

    override open var isHighlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }

    open override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }

    // MARK: - UIView override

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let insetBounds = CGRect(x: bounds.minX - additionalHitTestMargins.left,
                                 y: bounds.minY - additionalHitTestMargins.top,
                                 width: bounds.width + additionalHitTestMargins.right,
                                 height: bounds.height + additionalHitTestMargins.bottom)

        return super.point(inside: point, with: event)
            || insetBounds.contains(point)
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let pointInsideView = self.point(inside: point, with: event)

        // hitTest called multiple times, but we need only one
        // so the current solution is to pick a final call with nil event

        if !isEnabled && pointInsideView && event == nil {
            onDisabledStateTapHandler?()
        }

        let touchEventReceiver = super.hitTest(point, with: event)

        let shouldPropagateEvent = eventPropagations[state] ?? true

        if pointInsideView && touchEventReceiver == nil && !shouldPropagateEvent {
            return self // disable propagation
        }

        return touchEventReceiver
    }

    // MARK: - Public

    public func configure(activityIndicator: ActivityIndicator,
                          at position: ActivityIndicatorPosition) {

        self.activityIndicator = activityIndicator

        let titleInset = activityIndicator.intrinsicContentSize.width + position.offset

        switch position {
        case .center:
            titleEdgeInsets = .zero

        case .before:
            titleEdgeInsets = UIEdgeInsets(top: .zero,
                                           left: titleInset,
                                           bottom: .zero,
                                           right: .zero)

        case .after:
            titleEdgeInsets = UIEdgeInsets(top: .zero,
                                           left: .zero,
                                           bottom: .zero,
                                           right: titleInset)
        }

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(constraints(for: activityIndicator,
                                                at: position))
    }

    private func constraints(for activityIndicator: ActivityIndicator,
                             at position: ActivityIndicatorPosition) -> [NSLayoutConstraint] {
        switch position {
        case .center:
            return [
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]

        case let .before(view, offset):
            return [
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -offset)
            ]

        case let .after(view, offset):
            return [
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset)
            ]
        }
    }

    // MARK: - Private

    private func updateBackgroundColor() {
        if isEnabled {
            if isHighlighted {
                updateBackgroundColor(to: .highlighted)
            } else {
                updateBackgroundColor(to: .normal)
            }
        } else {
            updateBackgroundColor(to: .disabled)
        }
    }

    private func updateBackgroundColor(to state: State) {
        if let stateColor = backgroundColor(for: state) {
            backgroundColor = stateColor
        } else if state != .normal, let normalStateColor = backgroundColor(for: .normal) {
            backgroundColor = normalStateColor
        }
    }
}
