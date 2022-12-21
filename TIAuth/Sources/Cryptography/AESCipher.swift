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

open class AESCipher: Cipher {
    public struct CryptError: Error {
        public let ccCryptorStatus: Int32
        public let key: Data
        public let iv: Data
    }

    public var iv: Data
    public var key: Data

    public init(iv: Data, key: Data) {
        self.iv = iv
        self.key = key
    }

    // MARK: - Cipher

    public func encrypt(data: Data) -> Result<Data, CipherError> {
        crypt(data: data, operation: CCOperation(kCCEncrypt))
    }

    public func decrypt(data: Data) -> Result<Data, CipherError> {
        crypt(data: data, operation: CCOperation(kCCDecrypt))
    }

    private func crypt(data: Data, operation: CCOperation) -> Result<Data, CipherError> {
        let cryptDataLength = data.count + kCCBlockSizeAES128
        var cryptData = Data(count: cryptDataLength)

        var bytesLength = Int.zero

        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                    CCCrypt(operation,
                            CCAlgorithm(kCCAlgorithmAES),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyBytes.baseAddress,
                            key.count,
                            ivBytes.baseAddress,
                            dataBytes.baseAddress,
                            data.count,
                            cryptBytes.baseAddress,
                            cryptDataLength,
                            &bytesLength)
                    }
                }
            }
        }

        guard status == kCCSuccess else {
            let error = CryptError(ccCryptorStatus: status,
                                   key: key,
                                   iv: iv)

            if operation == kCCEncrypt {
                return .failure(.failedToEncrypt(data: data, error: error))
            } else {
                return .failure(.failedToDecrypt(encryptedData: data, error: error))
            }
        }

        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return .success(cryptData)
    }

}
