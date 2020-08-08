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

public struct CustomizableButtonState: OptionSet {

    // MARK: - OptionSet conformance

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    // MARK: - States

    public static let highlighted = CustomizableButtonState(rawValue: 1 << 1)
    public static let normal = CustomizableButtonState(rawValue: 1 << 2)
    public static let enabled = CustomizableButtonState(rawValue: 1 << 3)
    public static let disabled = CustomizableButtonState(rawValue: 1 << 4)
    public static let loading = CustomizableButtonState(rawValue: 1 << 5)

    // MARK: - Properties

    public var isLoading: Bool {
        return contains(.loading)
    }
}

/// container class that acts like a button and provides great customization
open class CustomizableButtonView: UIView, InitializableView, ConfigurableView {

    // MARK: - Stored Properties

    public private(set) var disposeBag = DisposeBag()

    private let button = CustomizableButton()

    open var tapOnDisabledButton: VoidBlock?

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
            removeSpinner()
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

    public var buttonTitle: String = "" {
        willSet {
            button.text = newValue
        }
    }

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
        if hidesLabelWhenLoading {
            button.titleLabel?.layer.opacity = active ? 0 : 1
        }

        spinnerView?.isHidden = !active

        if active {
            spinnerView?.startAnimating()
        } else {
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
        }
    }

    // MARK: - Layout

    private func configureConstraints() {
        button.pinToSuperview(with: appearance.buttonInsets)
        configureShadowViewConstraints()
        layoutIfNeeded()
    }

    private func configureSpinnerConstraints() {
        guard let spinnerView = spinnerView else {
            return
        }
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        switch appearance.spinnerPosition {
        case .center:
            constraints = [
                spinnerView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                spinnerView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
            ]

        case .leftToText(let offset):
            if let buttonLabel = button.titleLabel {
                constraints = [
                    spinnerView.centerYAnchor.constraint(equalTo: buttonLabel.centerYAnchor),
                    spinnerView.trailingAnchor.constraint(equalTo: buttonLabel.leadingAnchor, constant: -offset)
                ]
            }

        case .rightToText(let offset):
            if let buttonLabel = button.titleLabel {
                constraints = [
                    spinnerView.centerYAnchor.constraint(equalTo: buttonLabel.centerYAnchor),
                    spinnerView.leadingAnchor.constraint(equalTo: buttonLabel.trailingAnchor, constant: offset)
                ]
            }
        }

        NSLayoutConstraint.activate(constraints)
    }

    private func configureShadowViewConstraints() {
        shadowView.constraintToEdges(of: button, with: .zero)
    }

    // MARK: - Initializable View

    open func addViews() {
        addSubviews(shadowView, button)
    }

    open func configureAppearance() {
        button.titleLabel?.numberOfLines = appearance.numberOfLines
        button.titleLabel?.font = appearance.buttonFont
        button.alpha = appearance.alpha

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
        } else {
            button.layer.cornerRadius = 0
        }

        setNeedsDisplay()
    }

    open func configure(with viewModel: CustomizableButtonViewModel) {
        disposeBag = DisposeBag()
        viewModel.stateDriver.drive(stateBinder).disposed(by: disposeBag)
        viewModel.bind(tapObservable: tapObservable).disposed(by: disposeBag)

        button.text = viewModel.buttonTitle
        appearance = viewModel.appearance
    }

    private var stateBinder: Binder<CustomizableButtonState> {
        return Binder(self) { base, value in
            base.configureButton(withState: value)
            base.onStateChange(value)
        }
    }

    open func onStateChange(_ state: CustomizableButtonState) {
        /// override in subclass
    }

    open func configureButton(withState state: CustomizableButtonState) {
        button.isEnabled = ![.disabled, .loading].contains(state)
        isUserInteractionEnabled = button.isEnabled
        button.isHighlighted = state.contains(.highlighted) && !state.contains(.normal)
        set(active: state.contains(.loading))
        setNeedsDisplay()
    }
}

private extension UIView {
    func constraintToEdges(of view: UIView, with offset: UIEdgeInsets) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

public extension CustomizableButtonView {
    struct Appearance {

        public var buttonFont: UIFont
        public var buttonStateAttributtedTitles: [UIControl.State: NSAttributedString]
        public var buttonTitleStateColors: [UIControl.State: UIColor]
        public var buttonBackgroundStateColors: [UIControl.State: UIColor]
        public var buttonStateIcons: [UIControl.State: UIImage]
        public var buttonIconOffset: UIOffset
        public var buttonInsets: UIEdgeInsets
        public var buttonCornerRadius: CGFloat?
        public var spinnerPosition: SpinnerPosition
        public var numberOfLines: Int
        public var alpha: CGFloat

        public init(buttonFont: UIFont = .systemFont(ofSize: 15),
                    buttonStateAttributtedTitles: [UIControl.State: NSAttributedString] = [:],
                    buttonTitleStateColors: [UIControl.State: UIColor] = [:],
                    buttonBackgroundStateColors: [UIControl.State: UIColor] = [:],
                    buttonStateIcons: [UIControl.State: UIImage] = [:],
                    buttonIconOffset: UIOffset = .zero,
                    buttonInsets: UIEdgeInsets = .zero,
                    buttonCornerRadius: CGFloat? = nil,
                    spinnerPosition: SpinnerPosition = .center,
                    numberOfLines: Int = 0,
                    alpha: CGFloat = 1) {

            self.buttonFont = buttonFont
            self.buttonStateAttributtedTitles = buttonStateAttributtedTitles
            self.buttonTitleStateColors = buttonTitleStateColors
            self.buttonBackgroundStateColors = buttonBackgroundStateColors
            self.buttonStateIcons = buttonStateIcons
            self.buttonIconOffset = buttonIconOffset
            self.buttonInsets = buttonInsets
            self.buttonCornerRadius = buttonCornerRadius
            self.spinnerPosition = spinnerPosition
            self.numberOfLines = numberOfLines
            self.alpha = alpha
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
