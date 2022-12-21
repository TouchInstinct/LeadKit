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
import CommonCrypto

open class DefaultPBKDF2PasswordDerivator: PasswordDerivator {
    public struct CryptError: Error {
        public let derivationStatus: Int32
        public let password: String
        public let salt: Data

        func asCipherError() -> CipherError {
            var mutablePassword = password
            return .failedToEncrypt(data: mutablePassword.withUTF8 { Data($0) },
                                    error: self)
        }
    }

    public func derive(password: String, salt: Data) -> Result<Data, CipherError> {
        var failureResult: Result<Data, CipherError>?

        let derivedKeyBytes = Array<UInt8>(unsafeUninitializedCapacity: CryptoConstants.keyLength) { derivedKeyBuffer, initializedCount in
            guard let derivedKeyStartAddress = derivedKeyBuffer.baseAddress else {
                failureResult = .failure(CryptError(derivationStatus: CCStatus(kCCMemoryFailure),
                                             password: password,
                                             salt: salt)
                                    .asCipherError())

                initializedCount = .zero
                return
            }

            let deriviationStatus = salt.withContiguousStorageIfAvailable { saltBytes in
                CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    password,
                    password.count,
                    saltBytes.baseAddress,
                    salt.count,
                    CCPBKDFAlgorithm(kCCPRFHmacAlgSHA512),
                    UInt32(CryptoConstants.pbkdf2NumberOfIterations),
                    derivedKeyStartAddress,
                    CryptoConstants.keyLength)
            } ?? CCStatus(kCCParamError)

            guard deriviationStatus == kCCSuccess else {
                initializedCount = .zero
                failureResult = .failure(CryptError(derivationStatus: deriviationStatus,
                                             password: password,
                                             salt: salt)
                                    .asCipherError())
                return
            }
        }

        return failureResult ?? .success(Data(derivedKeyBytes))
    }
}
