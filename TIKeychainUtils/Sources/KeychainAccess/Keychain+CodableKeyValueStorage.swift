//
//  Copyright (c) 2020 Touch Instinct
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
import KeychainAccess
import TIFoundationUtils

extension Keychain: CodableKeyValueStorage {
    public func codableObject<Value: Decodable>(forKey key: StorageKey<Value>,
                                                decoder: CodableKeyValueDecoder) throws -> Value {

        let unwrappedStoredData: Data?

        do {
            unwrappedStoredData = try getData(key.rawValue)
        } catch {
            throw StorageError.unableToExtractData(underlyingError: error)
        }

        guard let storedData = unwrappedStoredData else {
            throw StorageError.valueNotFound
        }

        return try decoder.decodeDecodable(from: storedData, for: key)
    }

    public func set<Value: Encodable>(encodableObject: Value,
                                      forKey key: StorageKey<Value>,
                                      encoder: CodableKeyValueEncoder) throws {

        let objectData = try encoder.encodeEncodable(value: encodableObject, for: key)

        do {
            try set(objectData, key: key.rawValue)
        } catch {
            throw StorageError.unableToWriteData(underlyingError: error)
        }
    }

    public func removeCodableValue<Value: Codable>(forKey key: StorageKey<Value>) throws {
        do {
            try remove(key.rawValue)
        } catch {
            throw StorageError.unableToWriteData(underlyingError: error)
        }
    }
}
