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

public struct StringEncryptionResult {
    public struct DataRangeMismatch: Error {
        public let dataLength: Int
        public let valueRangeLowerBound: Int
    }

    public let salt: Data
    public let iv: Data
    public let value: Data

    private static var saltRange: Range<Int> {
        .zero..<CryptoConstants.saltLength
    }

    private static var ivRange: Range<Int> {
        saltRange.endIndex..<CryptoConstants.saltLength + CryptoConstants.ivLength
    }

    private static var valueRange: PartialRangeFrom<Int> {
        ivRange.endIndex...
    }

    public init(salt: Data, iv: Data, value: Data) {
        self.salt = salt
        self.iv = iv
        self.value = value
    }

    public init(storableData: Data) throws {
        guard Self.valueRange.contains(storableData.endIndex) else {
            throw DataRangeMismatch(dataLength: storableData.count,
                                    valueRangeLowerBound: Self.valueRange.lowerBound)
        }

        self.init(salt: storableData[Self.saltRange],
                  iv: storableData[Self.ivRange],
                  value: storableData[Self.valueRange])
    }

    public func asStorableData() -> Data {
        salt + iv + value
    }
}
