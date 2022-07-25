//
//  Copyright (c) 2022 Touch Instinct
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

import KeychainAccess
import Foundation

@MainActor
public protocol PinCodeStateStorage: AnyObject {
    var currentCodeInput: String { get set }
    var progress: Progress { get }
    var orderedPinPadActions: [PinCodeAction] { get set }
}

open class DefaultPinCodePresenter: PinCodePresenter {
    open class Output {
        public typealias OnLogoutClosure = () -> Void
        public typealias OnRecoverClosure = () -> Void

        public var onLogout: OnLogoutClosure
        public var onRecover: OnRecoverClosure

        public init(onLogout: @escaping OnLogoutClosure,
                    onRecover: @escaping OnRecoverClosure) {

            self.onLogout = onLogout
            self.onRecover = onRecover
        }
    }

    public struct Config {
        public enum Defaults {
            public static var codeLength: Int {
                4
            }

            public static var validator: DefaultInputValidator<DefaultViolation> {
                let violations: [DefaultViolation] = [
                    .equalDigits(minEqualDigits: 3),
                    .orderedDigits(ascending: true, minLength: 3),
                    .orderedDigits(ascending: false, minLength: 3)
                ]

                return DefaultInputValidator<DefaultViolation>(violations: violations) {
                    $0.defaultValidationRule
                }
            }
        }

        public var codeLength: Int
        public var defaultInputValidator: DefaultInputValidator<DefaultViolation>

        public init(codeLength: Int = Defaults.codeLength,
                    defaultInputValidator: DefaultInputValidator<DefaultViolation> = Defaults.validator) {

            self.codeLength = codeLength
            self.defaultInputValidator = defaultInputValidator
        }
    }

    public var output: Output

    public weak var stateStorage: PinCodeStateStorage? {
        didSet {
            updateProgress()
            updateOrderedPinPadActions()
        }
    }

    public var config: Config {
        didSet {
            updateProgress()
        }
    }

    // MARK: - Scenario properties

    public var filledPinCode: String {
        stateStorage?.currentCodeInput ?? String()
    }

    public weak var pinCodePresenterDelegate: PinCodePresenterDelegate?

    public var leadingPinPadAction: PinCodeAction? {
        didSet {
            updateOrderedPinPadActions()
        }
    }

    public var trailingPinPadAction: PinCodeAction? {
        didSet {
            updateOrderedPinPadActions()
        }
    }

    public init(output: Output,
                delegate: PinCodePresenterDelegate? = nil,
                config: Config = .init(),
                stateStorage: PinCodeStateStorage? = nil) {

        self.output = output
        self.pinCodePresenterDelegate = delegate
        self.config = config
        self.stateStorage = stateStorage
    }

    // MARK: - LifecyclePresenter

    open func viewDidPresented() {
        pinCodePresenterDelegate?.onViewDidPresented()
    }

    open func viewWillDestroy() {
        // cancel requests (if any)
    }

    // MARK: - User actions handling

    open func didPerform(action: PinCodeAction) {
        switch action {
        case let .digit(digit):
            handleDigitAction(digit: digit)
        case .backspace:
            handleBackspaceAction()
        case .biometry:
            handleBiometryAction()
        case .logout:
            handleLogoutAction()
        case .recover:
            handleRecoverAction()
        case let .custom(actionId):
            handleCustomAction(actionId: actionId)
        }
    }

    // MARK: - State management

    open func setCheckingState() {
        // disable UI
        // display animation
    }

    open func setIncorrectCodeState() {
        resetState()

        // show error message / animation
    }

    open func setValidCodeState() {
        // display animation
    }

    open func resetState() {
        stateStorage?.currentCodeInput = .init()
        updateProgress()
    }

    // MARK: - Subclass override

    open func handleDigitAction(digit: UInt) {
        withStateStorage {
            $0.currentCodeInput.append(contentsOf: format(digit: digit))

            let currentCodeValid = validate(currentCode: $0.currentCodeInput)

            if $0.currentCodeInput.count == config.codeLength && currentCodeValid {
                pinCodePresenterDelegate?.onFill(pinCode: $0.currentCodeInput)
            }
        }
    }

    open func validate(currentCode: String) -> Bool {
        let violations = config.defaultInputValidator.validate(input: currentCode)

        handleDefaultValidator(violations: violations)

        return violations.isEmpty
    }

    open func handleBackspaceAction() {
        stateStorage?.currentCodeInput.removeLast()
    }

    open func handleBiometryAction() {
        pinCodePresenterDelegate?.onBiometryRequest()
    }

    open func handleLogoutAction() {
        output.onLogout()
    }

    open func handleRecoverAction() {
        output.onRecover()
    }

    open func handleCustomAction(actionId: String) {
        // handle in subclass
    }

    open func format(digit: UInt) -> String {
        String(digit)
    }

    open func handleDefaultValidator(violations: Set<DefaultViolation>) {
        // handle in subclass
    }

    open func update(progress: Progress) {
        progress.totalUnitCount = Int64(config.codeLength)
        progress.completedUnitCount = Int64(stateStorage?.currentCodeInput.count ?? .zero)
    }

    // MARK: - Private

    private func updateProgress() {
        withStateStorage {
            update(progress: $0.progress)
        }
    }

    private func withStateStorage(actionClosure: (PinCodeStateStorage) -> Void) {
        guard let stateStorage = stateStorage else {
            return
        }

        actionClosure(stateStorage)
    }

    private func updateOrderedPinPadActions() {
        let first3RowsActions = (1...9).map(PinCodeAction.digit)
        var lastRowActions: [PinCodeAction] = [.digit(.zero)]

        if let leadingPinPadAction = leadingPinPadAction {
            lastRowActions.insert(leadingPinPadAction, at: .zero)
        }

        if let trailingPinPadAction = trailingPinPadAction {
            lastRowActions.append(trailingPinPadAction)
        }

        stateStorage?.orderedPinPadActions = first3RowsActions + lastRowActions
    }
}
