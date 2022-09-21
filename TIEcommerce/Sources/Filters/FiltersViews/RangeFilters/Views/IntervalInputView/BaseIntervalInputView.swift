import TIUIElements
import TIUIKitCore
import UIKit

open class BaseIntervalInputView: BaseInitializableView, UITextFieldDelegate {

    public enum TextFieldState {
        case fromValue
        case toValue
    }

    private var contentEdgesConstraints: EdgeConstraints?
    private var labelsSpacingConstraint: NSLayoutConstraint?

    public let state: TextFieldState

    public let intervalLabel = UILabel()
    public let inputTextField = UITextField()

    public var formatter: RangeValuesFormatterProtocol?

    open var intervalTextLabel: String {
        switch state {
        case .fromValue:
            return "от"
        case .toValue:
            return "до"
        }
    }

    open var validCharacterSet: CharacterSet {
        CharacterSet.decimalDigits.union(CharacterSet.init(charactersIn: "."))
    }

    open var fontColor: UIColor = .black {
        didSet {
            inputTextField.textColor = fontColor
            intervalLabel.textColor = fontColor
        }
    }

    open var intrinsicContentHeight: CGFloat? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    open var currentValue: Double {
        formatter?.double(fromString: inputTextField.text ?? "") ?? 0
    }

    open override var intrinsicContentSize: CGSize {
        if let height = intrinsicContentHeight {
            return CGSize(width: UIView.noIntrinsicMetric, height: height)
        }

        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }

    // MARK: - Init

    public init(state: TextFieldState) {
        self.state = state

        super.init(frame: .zero)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    open override func addViews() {
        super.addViews()

        addSubviews(intervalLabel, inputTextField)
    }

    open override func configureLayout() {
        super.configureLayout()

        [intervalLabel, inputTextField].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        let contentEdgesConstraints = EdgeConstraints(leadingConstraint: intervalLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                                      trailingConstraint: inputTextField.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                                                      topConstraint: intervalLabel.topAnchor.constraint(equalTo: topAnchor),
                                                      bottomConstraint: intervalLabel.bottomAnchor.constraint(equalTo: bottomAnchor))

        let labelsSpacingConstraint = inputTextField.leadingAnchor.constraint(equalTo: intervalLabel.trailingAnchor)

        NSLayoutConstraint.activate(
            contentEdgesConstraints.allConstraints
            +
            [
                labelsSpacingConstraint,
                inputTextField.centerYAnchor.constraint(equalTo: intervalLabel.centerYAnchor)
            ]
        )

        self.labelsSpacingConstraint = labelsSpacingConstraint
        self.contentEdgesConstraints = contentEdgesConstraints
    }

    open override func configureAppearance() {
        super.configureAppearance()

        inputTextField.keyboardType = .numberPad

        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1

        layer.round(corners: .allCorners, radius: 8)
    }

    open override func bindViews() {
        super.bindViews()

        inputTextField.delegate = self
        inputTextField.addTarget(target, action: #selector(formatValue), for: .editingChanged)
    }

    open override func localize() {
        super.localize()

        intervalLabel.text = intervalTextLabel
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        inputTextField.becomeFirstResponder()
    }

    open func configure(with value: Double) {
        inputTextField.text = formatter?.string(fromDouble: value)
    }

    open func configure(with formatter: RangeValuesFormatterProtocol) {
        self.formatter = formatter
    }

    // MARK: - UITextFieldDelegate

    open func textField(_ textField: UITextField,
                        shouldChangeCharactersIn range: NSRange,
                        replacementString string: String) -> Bool {

        let characterSet = CharacterSet(charactersIn: string)

        textField.undoManager?.removeAllActions()

        return validCharacterSet.isSuperset(of: characterSet)
    }

    // MARK: - Open methods

    open func updateContentInsets(_ insets: UIEdgeInsets) {
        contentEdgesConstraints?.update(from: insets)
    }

    open func updateLabelsSpacing(_ spacing: CGFloat) {
        labelsSpacingConstraint?.constant += spacing
    }

    // MARK: - Public methods

    public func addTarget(_ target: Any?, valueIsChangedAction: Selector) {
        inputTextField.addTarget(target, action: valueIsChangedAction, for: .editingChanged)
    }

    public func addTarget(_ target: AnyObject, valueDidEndChangingAction: Selector) {
        inputTextField.addTarget(target, action: valueDidEndChangingAction, for: .editingDidEnd)
    }

    // MARK: - Private methods

    @objc private func formatValue() {
        let onlyDigits = inputTextField.text.orEmpty
            .components(separatedBy: validCharacterSet.inverted)
            .joined()

        let newValue = formatter?.double(fromString: onlyDigits)
        inputTextField.text = formatter?.string(fromDouble: newValue ?? 0)
    }
}
