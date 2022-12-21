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
import Security

open class DefaultTokenCipher: TokenCipher {
    public var saltPreprocessor: SaltPreprocessor
    public var passwordDerivator: PasswordDerivator

    public init(saltPreprocessor: SaltPreprocessor, passwordDerivator: PasswordDerivator) {
        self.saltPreprocessor = saltPreprocessor
        self.passwordDerivator = passwordDerivator
    }

    open func createCipher(iv: Data, key: Data) -> Cipher {
        AESCipher(iv: iv, key: key)
    }

    open func generateIV() -> Data {
        generateRandomData(count: CryptoConstants.ivLength)
    }

    open func generateSalt() -> Data {
        generateRandomData(count: CryptoConstants.saltLength)
    }

    open func generateRandomData(count: Int) -> Data {
        let randomBytes = Array<UInt8>(unsafeUninitializedCapacity: count) { buffer, initializedCount in
            guard let startAddress = buffer.baseAddress,
                  SecRandomCopyBytes(kSecRandomDefault,
                                     count,
                                     startAddress) == errSecSuccess else {

                      initializedCount = .zero
                      return
                  }
            initializedCount = count
        }

        return Data(randomBytes)
    }

    // MARK: - TokenCipher

    open func derive(password: String, using salt: Data) -> Result<Data, CipherError> {
        passwordDerivator.derive(password: password,
                                 salt: saltPreprocessor.preprocess(salt: salt))
    }

    open func encrypt(token: Data, using password: String) -> Result<StringEncryptionResult, CipherError> {
        let iv = generateIV()
        let salt = generateSalt()

        return derive(password: password, using: salt)
            .flatMap {
                createCipher(iv: iv, key: $0)
                    .encrypt(data: token)
                    .map {
                        StringEncryptionResult(salt: salt, iv: iv, value: $0)
                    }
            }
    }

    open func decrypt(token: StringEncryptionResult, using key: Data) -> Result<Data, CipherError> {
        createCipher(iv: token.iv, key: key)
            .decrypt(data: token.value)
    }

    open func decrypt(token: StringEncryptionResult, using password: String) -> Result<Data, CipherError> {
        passwordDerivator.derive(password: password,
                                 salt: saltPreprocessor.preprocess(salt: token.salt))
            .flatMap {
                createCipher(iv: token.iv,
                             key: $0)
                    .decrypt(data: token.value)
            }
    }
}
