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

import TIFoundationUtils
import UIKit.UIDevice
import LocalAuthentication
import Foundation

public enum PinCodeScenarioError: Error {
    case encryptDecryptError(CipherError)
    case readWriteError(StorageError)
}

public typealias DefaultPinCodeScenarioResult<SuccessResult> = Result<SuccessResult, PinCodeScenarioError>

@MainActor
open class BasePinCodeScenario<SuccessResult>: PinCodeScenario, PinCodePresenterDelegate, AsyncRunExecutable {
    public typealias ScenarioResult = DefaultPinCodeScenarioResult<SuccessResult>

    @MainActor
    public enum Defaults {
        public static var tokenCipher: DefaultTokenCipher {
            DefaultTokenCipher(saltPreprocessor: DefaultSaltPreprocessor { UIDevice.current.identifierForVendor?.uuidString },
                               passwordDerivator: DefaultPBKDF2PasswordDerivator())
        }
    }

    public let pinCodePresenter: PinCodePresenter
    public var biometryService: BiometryService = LAContext()
    public var biometrySettingsService: BiometrySettingsStorage = DefaultBiometrySettingsStorage()
    public var encryptedTokenStorage: SingleValueAuthKeychainStorage<StringEncryptionResult> = DefaultEncryptedTokenStorage()
    public var encryptedTokenKeyStorage: SingleValueAuthKeychainStorage<Data> = DefaultEncryptedTokenKeyStorage()
    public var tokenCipher: TokenCipher = Defaults.tokenCipher

    public private(set) var scenarioCompletion: CompletionClosure?

    public init(pinCodePresenter: PinCodePresenter) {
        self.pinCodePresenter = pinCodePresenter
        self.pinCodePresenter.pinCodePresenterDelegate = self
    }

    // MARK: - PinCodeScenario

    open func run(completion: @escaping CompletionClosure) {
        scenarioCompletion = completion
    }

    // MARK: - PinCodePresenterDelegate

    open func onViewDidPresented() {
        // override in subclass
    }

    open func onBiometryRequest() {
        // override in subclass
    }

    open func onPinChanged() {
        // override in subclass
    }

    open func onFill(pinCode: String) {
        // override in subclass
    }
}

public protocol AsyncRunExecutable: AnyObject {}

extension AsyncRunExecutable {
    func asyncRun(qos: DispatchQoS.QoSClass = .userInitiated, workUnit: @escaping (Self) -> ()) {
        DispatchQueue.global(qos: qos).async { [weak self] in
            guard let self = self else {
                return
            }

            workUnit(self)
        }
    }
}
