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
import TIFoundationUtils

@MainActor
open class CreatePinCodeScenario: BasePinCodeScenario<StringEncryptionResult> {
    private let token: Data
    private var firstPinCode: String?

    public init(pinCodePresenter: PinCodePresenter, token: Data) {
        self.token = token

        super.init(pinCodePresenter: pinCodePresenter)
    }

    open override func onFill(pinCode: String) {
        super.onFill(pinCode: pinCode)

        guard firstPinCode != nil else {
            firstPinCode = pinCode

            pinCodePresenter.resetState()

            return
        }

        guard firstPinCode == pinCode else {
            pinCodePresenter.setIncorrectCodeState()
            return
        }

        asyncRun { scenario in
            let result: ScenarioResult = scenario.tokenCipher.encrypt(token: scenario.token, using: pinCode)
                .mapError { .encryptDecryptError($0) }
                .flatMap { stringEncryptionResult in
                    scenario.encryptedTokenStorage.store(value: stringEncryptionResult)
                        .map { stringEncryptionResult }
                        .mapError { .readWriteError($0) }
                }

            DispatchQueue.main.async {
                scenario.scenarioCompletion?(result)
            }
        }
    }
}
