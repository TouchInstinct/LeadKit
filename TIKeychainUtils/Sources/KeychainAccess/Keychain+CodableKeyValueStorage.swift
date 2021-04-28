import Foundation
import KeychainAccess

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
