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

extension UserDefaults: CodableKeyValueStorage {
    public func codableObject<Value: Decodable>(forKey key: StorageKey<Value>,
                                                decoder: CodableKeyValueDecoder) throws -> Value {

        guard let storedData = data(forKey: key.rawValue) else {
            throw StorageError.valueNotFound
        }

        return try decoder.decodeDecodable(from: storedData, for: key)
    }

    public func set<Value: Encodable>(encodableObject: Value,
                                      forKey key: StorageKey<Value>,
                                      encoder: CodableKeyValueEncoder) throws {

        let encodedData = try encoder.encodeEncodable(value: encodableObject, for: key)

        set(encodedData, forKey: key.rawValue)
    }

    public func removeCodableValue<Value: Codable>(forKey key: StorageKey<Value>) throws {
        guard data(forKey: key.rawValue) != nil else {
            throw StorageError.valueNotFound
        }

        removeObject(forKey: key.rawValue)
    }
}
