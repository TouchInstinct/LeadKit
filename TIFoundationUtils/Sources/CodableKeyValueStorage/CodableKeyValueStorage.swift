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

public protocol CodableKeyValueStorage {
    /// Returns the object with specified type associated with the first occurrence of the specified key.
    /// - Parameters:
    ///   - key: A key in the storage.
    ///   - decoder: CodableKeyValueDecoder to decode stored data.
    /// - Returns: The object with specified type associated with the specified key,
    /// or throw exception if the key was not found.
    /// - Throws: CodableStorageError
    func codableObject<Value: Decodable>(forKey key: StorageKey<Value>,
                                         decoder: CodableKeyValueDecoder) throws -> Value

    /// Set or remove the value of the specified key in the storage.
    /// - Parameters:
    ///   - object: The object with specified type to store.
    ///   - key: The key with which to associate with the value.
    ///   - encoder: CodableKeyValueEncoder to encode to encode passed object.
    /// - Throws: EncodingError if error is occured during passed object encoding.
    func set<Value: Encodable>(encodableObject: Value,
                               forKey key: StorageKey<Value>,
                               encoder: CodableKeyValueEncoder) throws

    /// Removes value for specific key
    /// - Parameter key: The key with which to associate with the value.
    /// - Throws: EncodingError if error is occured during reading/writing.
    func removeCodableValue<Value: Codable>(forKey key: StorageKey<Value>) throws
}

public extension CodableKeyValueStorage {

    /// Returns the object with specified type associated with the first occurrence of the specified key.
    /// - Parameters:
    ///   - key: A key in the storage.
    ///   - defaultValue: A default value that will be used if there is no such value for specified key,
    ///   - decoder: CodableKeyValueDecoder to decode stored data.
    /// or if error occurred during decoding
    /// - Returns: The object with specified type associated with the specified key, or passed default value
    /// if there is no such value for specified key or if error occurred during mapping.
    func codableObject<Value: Decodable>(forKey key: StorageKey<Value>,
                                         defaultValue: Value,
                                         decoder: CodableKeyValueDecoder = JSONKeyValueDecoder()) -> Value {

        (try? codableObject(forKey: key, decoder: decoder)) ?? defaultValue
    }

    func setOrRemove<Value: Codable>(codableObject: Value?,
                                     forKey key: StorageKey<Value>,
                                     encoder: CodableKeyValueEncoder = JSONKeyValueEncoder()) throws {

        if let codableObject = codableObject {
            try set(encodableObject: codableObject, forKey: key, encoder: encoder)
        } else {
            try? removeCodableValue(forKey: key)
        }
    }

    subscript<Value: Codable>(key: StorageKey<Value>,
                              decoder: CodableKeyValueDecoder = JSONKeyValueDecoder(),
                              encoder: CodableKeyValueEncoder = JSONKeyValueEncoder()) -> Value? {

        get {
            try? codableObject(forKey: key, decoder: decoder)
        }
        set {
            try? setOrRemove(codableObject: newValue, forKey: key, encoder: encoder)
        }
    }
}
