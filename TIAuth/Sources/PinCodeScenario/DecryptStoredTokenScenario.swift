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

import Foundation
import LocalAuthentication
import UIKit
import TIFoundationUtils

@MainActor
open class DecryptStoredTokenScenario: BasePinCodeScenario<Data> {
    public typealias TokenValidationClosure = (Data, @MainActor (Bool) -> Void) -> Void

    public var tokenValidation: TokenValidationClosure

    public var canAuthWithBiometry: Bool {
        biometrySettingsService.isBiometryAuthEnabled && biometryService.isBiometryAuthAvailable
    }

    public init(pinCodePresenter: PinCodePresenter,
                tokenValidation: @escaping TokenValidationClosure) {

        self.tokenValidation = tokenValidation

        super.init(pinCodePresenter: pinCodePresenter)

        pinCodePresenter.leadingPinPadAction = .logout

        updateTrailingAction()
    }

    // MARK: - PinCodePresenterDelegate

    open override func onViewDidPresented() {
        super.onViewDidPresented()

        let canAuthWithBiometry = biometrySettingsService.isBiometryAuthEnabled && biometryService.isBiometryAuthAvailable
        let hasStoredKey = encryptedTokenKeyStorage.hasStoredValue()

        if canAuthWithBiometry && hasStoredKey {
            startWithBiometry()
        }
    }

    open override func onBiometryRequest() {
        super.onBiometryRequest()

        startWithBiometry()
    }

    open override func onPinChanged() {
        super.onPinChanged()

        updateTrailingAction()
    }

    open override func onFill(pinCode: String) {
        super.onFill(pinCode: pinCode)

        pinCodePresenter.setCheckingState()

        asyncRun { scenario in
            let scenarioResult: ScenarioResult = scenario.encryptedTokenStorage.getValue()
                .mapError { .readWriteError($0) }
                .flatMap {
                    scenario.tokenCipher.decrypt(token: $0, using: pinCode)
                        .mapError { .encryptDecryptError($0) }
                }

            guard case let .success(token) = scenarioResult else {
                DispatchQueue.main.async {
                    scenario.scenarioCompletion?(scenarioResult)
                }

                return
            }

            scenario.tokenValidation(token) { validationPassed in
                if validationPassed {
                    scenario.pinCodePresenter.setValidCodeState()
                    scenario.scenarioCompletion?(scenarioResult)
                } else {
                    scenario.pinCodePresenter.setIncorrectCodeState()
                }
            }
        }
    }

    // MARK: - Private

    private func updateTrailingAction() {
        guard pinCodePresenter.filledPinCode.isEmpty else {
            pinCodePresenter.trailingPinPadAction = .backspace
            return
        }

        if canAuthWithBiometry, let pinBiometryType = biometryService.biometryType.pinCodeBiometryType {
            pinCodePresenter.trailingPinPadAction = .biometry(pinBiometryType)
        } else {
            pinCodePresenter.trailingPinPadAction = .backspace
        }
    }

    private func startWithBiometry() {
        asyncRun { scenario in
            let scenarioResult: ScenarioResult = scenario.encryptedTokenKeyStorage.getValue()
                .flatMap { key in
                    scenario.encryptedTokenStorage.getValue().map {
                        (encryptedToken: $0, key: key)
                    }
                }
                .mapError { .readWriteError($0) }
                .flatMap { (key, stringEncryptionResult) in
                    scenario.tokenCipher.decrypt(token: key, using: stringEncryptionResult)
                        .mapError { .encryptDecryptError($0) }
                }

            DispatchQueue.main.async {
                scenario.scenarioCompletion?(scenarioResult)
            }
        }
    }
}

extension LABiometryType {
    var pinCodeBiometryType: PinCodeActionBiometryType? {
        switch self {
        case .none:
            return nil
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        }
    }
}
