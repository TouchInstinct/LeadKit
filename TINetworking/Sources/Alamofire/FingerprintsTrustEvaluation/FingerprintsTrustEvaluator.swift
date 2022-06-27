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

import Alamofire
import Security
import Foundation
import CommonCrypto

open class FingerprintsTrustEvaluator: ServerTrustEvaluating {
    public enum PinValidationFailed: Error {
        case unableToExtractPin(trust: SecTrust)
        case serverPinMissing(knownFingerprints: Set<String>, serverFingerprint: String)
    }

    private let fingerprintsProvider: FingerprintsProvider

    public init(fingerprintsProvider: FingerprintsProvider) {
        self.fingerprintsProvider = fingerprintsProvider
    }

    open func evaluate(_ trust: SecTrust, forHost host: String) throws {
        guard SecTrustGetCertificateCount(trust) > 0,
              let certificate = SecTrustGetCertificateAtIndex(trust, 0) else {

                  throw PinValidationFailed.unableToExtractPin(trust: trust)
              }

        let certificateData = SecCertificateCopyData(certificate) as Data

        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        certificateData.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(certificateData.count), &hash)
        }

        let certificateHash = Data(hash)

        let certificatePin = certificateHash
            .map { String(format: "%02X", $0) }
            .joined(separator: ":")

        let knownFingerprintsForHost = fingerprintsProvider.fingerprints(forHost: host)

        guard knownFingerprintsForHost.contains(certificatePin) else {
            throw PinValidationFailed.serverPinMissing(knownFingerprints: knownFingerprintsForHost,
                                                       serverFingerprint: certificatePin)
        }
    }
}

