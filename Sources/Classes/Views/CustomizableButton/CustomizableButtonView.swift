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

    // MARK: - OptionSet conformance

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    // MARK: - States

    public static let highlighted = BigBossButtonState(rawValue: 1 << 1)
    public static let normal = BigBossButtonState(rawValue: 1 << 2)
    public static let enabled = BigBossButtonState(rawValue: 1 << 3)
    public static let disabled = BigBossButtonState(rawValue: 1 << 4)
    public static let loading = BigBossButtonState(rawValue: 1 << 5)

    // MARK: - Properties

    public var isLoading: Bool {
        return contains(.loading)
    }
}

open class CustomizableButtonView: UIView {

    // MARK: - Stored Properties

    private let disposeBag = DisposeBag()
    private let button = CustomizableButton()
    public var tapOnDisabledButton: VoidBlock?

    public var shadowView = UIView() {
        willSet {
            shadowView.removeFromSuperview()
        }
        didSet {
            insertSubview(shadowView, at: 0)
            configureShadowViewConstraints()
        }
    }

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

    public var appearance = Appearance() {
        didSet {
            configureAppearance()
            configureConstraints()
        }
    }

    public var buttonIsDisabledWhileLoading = false
    public var hidesLabelWhenLoading = false

    // MARK: - Computed Properties

    public var tapObservable: Observable<Void> {
        return button.rx.tap.asObservable()
    }

    override open var forFirstBaselineLayout: UIView {
        return button.forFirstBaselineLayout
    }

    override open var forLastBaselineLayout: UIView {
        return button.forLastBaselineLayout
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if var touchPoint = touches.first?.location(in: self) {
            touchPoint = convert(touchPoint, to: self)
            if button.frame.contains(touchPoint) && !button.isEnabled {
                tapOnDisabledButton?()
            }
        }
        super.touchesBegan(touches, with: event)
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

    // MARK: - UI

    override open func layoutSubviews() {
        super.layoutSubviews()
        if shadowView.layer.cornerRadius == 0 {
            shadowView.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
        }
    }

    private func set(active: Bool) {
        button.isEnabled = buttonIsDisabledWhileLoading ? !active : true
        
        if hidesLabelWhenLoading {
            button.titleLabel?.layer.opacity = active ? 0 : 1
        }

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
            spinner.isHidden = true
        }
    }

    private func removeSpinner() {
        if spinnerView != nil {
            self.spinnerView?.removeFromSuperview()
            self.spinnerView = nil
        }
    }

    // MARK: - Layout

    private func configureConstraints() {
        button.pinToSuperview(with: appearance.buttonInsets)
        configureShadowViewConstraints()
    }

    private func configureSpinnerConstraints() {
        spinnerView?.translatesAutoresizingMaskIntoConstraints = false
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
        self.translatesAutoresizingMaskIntoConstraints = false
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

        button.titleLabel?.isHidden = true
    }
}

extension CustomizableButtonView: ConfigurableView {
    public func configure(with viewModel: CustomizableButtonViewModel) {
        button.titleLabel?.numberOfLines = 0
        viewModel.stateDriver
            .drive(stateBinder)
            .disposed(by: disposeBag)

        viewModel
            .bind(tapObservable: tapObservable)
            .disposed(by: disposeBag)

        appearance = viewModel.appearance
    }

    private var stateBinder: Binder<BigBossButtonState> {
        return Binder(self) { base, value in
            base.configureButton(withState: value)
            base.onStateChange(value)
        }
    }

    open func onStateChange(_ state: BigBossButtonState) {
        /// override in subclass
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

        if state.contains(.normal) {
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

        var buttonCornerRadius: CGFloat?

        var buttonShadowPadding: CGFloat
        var spinnerPosition: SpinnerPosition

        public init(buttonFont: UIFont = .systemFont(ofSize: 15),
                    buttonStateTitles: [UIControl.State: String] = [:],
                    buttonStateAttributtedTitles: [UIControl.State: NSAttributedString] = [:],
                    buttonTitleStateColors: [UIControl.State: UIColor] = [:],
                    buttonBackgroundStateColors: [UIControl.State: UIColor] = [:],
                    buttonStateIcons: [UIControl.State: UIImage] = [:],
                    buttonIconOffset: UIOffset = .zero,
                    buttonInsets: UIEdgeInsets = .zero,
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
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Int(rawValue))
    }
}
