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

import RxSwift
import RxCocoa

public typealias Spinner = UIView & Animatable

public struct BigBossButtonState: OptionSet {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    static let highlighted = BigBossButtonState(rawValue: 1 << 1)
    static let unhighlighted = BigBossButtonState(rawValue: 1 << 2)
    static let enabled = BigBossButtonState(rawValue: 1 << 3)
    static let disabled = BigBossButtonState(rawValue: 1 << 4)

    static let loading = BigBossButtonState(rawValue: 1 << 5)

    var isLoading: Bool {
        return self.contains(.loading)
    }
}

open class CustomizableButtonView: UIView {

    private let disposeBag = DisposeBag()

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if var touchPoint = touches.first?.location(in: self) {
            touchPoint = convert(touchPoint, to: self)
            if button.frame.contains(touchPoint) && !button.isEnabled {
                tapOnDisabledButton?()
            }
        }
        super.touchesBegan(touches, with: event)
    }

    // MARK: - Stored Properties

    public var spinnerView: Spinner? {
        willSet {
            if newValue == nil {
                removeSpinner()
            }
        }

        didSet {
            if spinnerView != nil {
                addSpinner()
            }
        }
    }

    private let button = CustomizableButton()

    public var shadowView = UIView() {
        willSet {
            shadowView.removeFromSuperview()
        }
        didSet {
            insertSubview(shadowView, at: 0)
            configureShadowViewConstraints()
        }
    }

    private var isEnabledObserver: NSKeyValueObservation?
    private var isHighlightedObserver: NSKeyValueObservation?

    public var tapOnDisabledButton: VoidBlock?

    public var appearance = Appearance() {
        didSet {
            configureAppearance()
            configureConstraints()
        }
    }

    // MARK: - Initialization

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    // MARK: - Drivers

    open var tapObservable: Observable<Void> {
        return button.rx.tap.asObservable()
    }

    // MARK: - Button State Observation

    //    private func observeIsEnabled() -> NSKeyValueObservation {
    //        return button.observe(\BigBossButton.isEnabled, options: .new) { [weak self] _, isEnabled in
    //
    //            guard let self = self else {
    //                return
    //            }
    //
    //            if let isEnabled = isEnabled.newValue {
    //                var state = self.stateRelay.value
    //                state.subtract([.enabled, .disabled])
    //                state.insert(isEnabled ? .enabled : .disabled)
    //                self.stateRelay.accept(state)
    //            }
    //        }
    //    }
    //
    //    private func observeIsHighlighted() -> NSKeyValueObservation {
    //        return button.observe(\BigBossButton.isHighlighted, options: .new,
    //      changeHandler: { [weak self] _, isHighlighted in
    //
    //            guard let self = self else {
    //                return
    //            }
    //
    //            if let isHighlighted = isHighlighted.newValue {
    //                var state = self.stateRelay.value
    //                state.subtract([.highlighted, .unhighlighted])
    //                state.insert(isHighlighted ? .highlighted : .unhighlighted)
    //                self.stateRelay.accept(state)
    //            }
    //        })
    //    }

    // MARK: - UI

    override open func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
    }

    public var buttonIsDisabledWhileLoading = false

    private func set(active: Bool) {
        button.isEnabled = buttonIsDisabledWhileLoading ? !active : true
        if active {
            spinnerView?.isHidden = false
            spinnerView?.startAnimating()
        } else {
            spinnerView?.isHidden = true
            spinnerView?.stopAnimating()
        }
    }

    private func addSpinner() {
        if let spinner = spinnerView {
            addSubview(spinner)
            configureSpinnerConstraints()
        }
    }

    private func removeSpinner() {
        if spinnerView != nil {
            self.spinnerView?.removeFromSuperview()
            self.spinnerView = nil
        }
    }

    // MARK: - Layout

    override open var forFirstBaselineLayout: UIView {
        return button.forFirstBaselineLayout
    }

    override open var forLastBaselineLayout: UIView {
        return button.forLastBaselineLayout
    }

    private func configureConstraints() {
        button.constaintToEdges(of: self, with: appearance.buttonInsets)
        configureShadowViewConstraints()
    }

    private func configureSpinnerConstraints() {
        switch appearance.spinnerPosition {
        case .center:
            spinnerView?.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            spinnerView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        case .leftToText(let offset):
            if let buttonLabel = button.titleLabel {
                spinnerView?.centerYAnchor.constraint(equalTo: buttonLabel.centerYAnchor).isActive = true
                spinnerView?.trailingAnchor.constraint(equalTo: buttonLabel.leadingAnchor,
                                                       constant: -offset).isActive = true
            }
        case .rightToText(let offset):
            if let buttonLabel = button.titleLabel {
                spinnerView?.centerYAnchor.constraint(equalTo: buttonLabel.centerYAnchor).isActive = true
                spinnerView?.leadingAnchor.constraint(equalTo: buttonLabel.trailingAnchor,
                                                      constant: offset).isActive = true
            }
        }
    }

    private func configureShadowViewConstraints() {
        shadowView.constaintToEdges(of: button, with: .zero)
    }
}

private extension UIView {
    func constaintToEdges(of view: UIView, with offset: UIEdgeInsets) {
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom).isActive = true
    }
}

extension CustomizableButtonView: InitializableView {

    public func addViews() {
        addSubviews(shadowView, button)
    }

    public func configureAppearance() {
        button.titleLabel?.font = appearance.buttonFont

        button.set(titles: appearance.buttonStateTitles)
        button.set(attributtedTitles: appearance.buttonStateAttributtedTitles)
        button.set(titleColors: appearance.buttonTitleStateColors)
        button.set(images: appearance.buttonStateIcons)
        button.set(backgroundColors: appearance.buttonBackgroundStateColors)

        let offset = appearance.buttonIconOffset
        button.imageEdgeInsets = UIEdgeInsets(top: offset.vertical,
                                              left: offset.horizontal,
                                              bottom: -offset.vertical,
                                              right: -offset.horizontal)

        if let cornerRadius = appearance.buttonCornerRadius {
            button.layer.cornerRadius = cornerRadius
        }
    }
}

extension CustomizableButtonView: ConfigurableView {
    public func configure(with viewModel: CustomizableButtonViewModel) {
        button.titleLabel?.numberOfLines = 0
        viewModel.stateObservable
            .skip(1)
            .do(onNext: { [weak self] state in
                self?.configureButton(withState: state)
                self?.onStateChange(state)
            })
            .subscribe()
            .disposed(by: disposeBag)

        viewModel
            .bind(tapObservable: tapObservable)
            .disposed(by: disposeBag)

        appearance = viewModel.appearance
    }

    open func onStateChange(_ state: BigBossButtonState) {

    }

    open func configureButton(withState state: BigBossButtonState) {
        if state.contains(.enabled) {
            button.isEnabled = true
        }

        if state.contains(.disabled) {
            button.isEnabled = false
        }

        if state.contains(.highlighted) {
            button.isHighlighted = true
        }

        if state.contains(.unhighlighted) {
            button.isHighlighted = false
        }

        if state.contains(.loading) {
            set(active: true)
        } else {
            set(active: false)
        }
    }
}

public extension CustomizableButtonView {
    struct Appearance {

        var buttonFont: UIFont

        var buttonStateTitles: [UIControl.State: String]
        var buttonStateAttributtedTitles: [UIControl.State: NSAttributedString]
        var buttonTitleStateColors: [UIControl.State: UIColor]
        var buttonBackgroundStateColors: [UIControl.State: UIColor]
        var buttonStateIcons: [UIControl.State: UIImage]

        var buttonIconOffset: UIOffset
        var buttonInsets: UIEdgeInsets

        var buttonHeight: CGFloat
        var buttonCornerRadius: CGFloat?

        var buttonShadowPadding: CGFloat
        var spinnerPosition: SpinnerPosition

        init(buttonFont: UIFont = .systemFont(ofSize: 15),
             buttonStateTitles: [UIControl.State: String] = [:],
             buttonStateAttributtedTitles: [UIControl.State: NSAttributedString] = [:],
             buttonTitleStateColors: [UIControl.State: UIColor] = [:],
             buttonBackgroundStateColors: [UIControl.State: UIColor] = [:],
             buttonStateIcons: [UIControl.State: UIImage] = [:],
             buttonIconOffset: UIOffset = .zero,
             buttonInsets: UIEdgeInsets = .zero,
             buttonHeight: CGFloat = 50,
             buttonCornerRadius: CGFloat? = nil,
             buttonShadowPadding: CGFloat = 0,
             spinnerPosition: SpinnerPosition = .center
            ) {

            self.buttonFont = buttonFont

            self.buttonStateTitles = buttonStateTitles
            self.buttonStateAttributtedTitles = buttonStateAttributtedTitles
            self.buttonTitleStateColors = buttonTitleStateColors
            self.buttonBackgroundStateColors = buttonBackgroundStateColors
            self.buttonStateIcons = buttonStateIcons

            self.buttonIconOffset = buttonIconOffset
            self.buttonInsets = buttonInsets

            self.buttonHeight = buttonHeight
            self.buttonCornerRadius = buttonCornerRadius

            self.buttonShadowPadding = buttonShadowPadding
            self.spinnerPosition = spinnerPosition
        }

    }

    enum SpinnerPosition {
        case center
        case leftToText(offset: CGFloat)
        case rightToText(offset: CGFloat)
    }
}

extension UIControl.State: Hashable {
    //swiftlint:disable:next - inout_keyword
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Int(rawValue))
    }
}
