import RxSwift

public enum UserDefaultsError: Error {

    case noSuchValue(key: String)
    case unableToDecode(decodingError: Error)
}

public extension UserDefaults {

    /// Returns the object with specified type associated with the first occurrence of the specified default.
    ///
    /// - Parameters:
    ///   - key: A key in the current user's defaults database.
    ///   - decoder: JSON decoder to decode stored data.
    /// - Returns: The object with specified type associated with the specified key,
    /// or throw exception if the key was not found.
    /// - Throws: One of cases in UserDefaultsError
    func object<T: Decodable>(forKey key: String, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        guard let storedData = data(forKey: key) else {
            throw UserDefaultsError.noSuchValue(key: key)
        }

        do {
            return try decoder.decode(T.self, from: storedData)
        } catch {
            throw UserDefaultsError.unableToDecode(decodingError: error)
        }
    }

    /// Returns the object with specified type associated with the first occurrence of the specified default.
    ///
    /// - Parameters:
    ///   - key: A key in the current user's defaults database.
    ///   - defaultValue: A default value which will be used if there is no such value for specified key,
    /// or if error occurred during mapping
    ///   - decoder: JSON decoder to decode stored data.
    /// - Returns: The object with specified type associated with the specified key, or passed default value
    /// if there is no such value for specified key or if error occurred during mapping.
    func object<T: Decodable>(forKey key: String, defaultValue: T, decoder: JSONDecoder = JSONDecoder()) -> T {
        (try? object(forKey: key, decoder: decoder)) ?? defaultValue
    }

    /// Set or remove the value of the specified default key in the standard application domain.
    ///
    /// - Parameters:
    ///   - object: The object with specified type to store or nil to remove it from the defaults database.
    ///   - key: The key with which to associate with the value.
    ///   - encoder: JSON encoder to encode to encode passed object.
    /// - Throws: EncodingError if error is occured during passed object encoding.
    func set<T: Encodable>(object: T?, forKey key: String, encoder: JSONEncoder = JSONEncoder()) throws {
        if let object = object {
            set(try encoder.encode(object), forKey: key)
        } else {
            set(nil, forKey: key)
        }
    }

    subscript<T: Codable>(key: String) -> T? {
        get {
            try? object(forKey: key)
        }
        set {
            try? set(object: newValue, forKey: key)
        }
    }
}

public extension Reactive where Base: UserDefaults {

    /// Reactive version of object<T>(forKey:decoder:) -> T.
    ///
    /// - Parameters:
    ///   - key: A key in the current user's defaults database.
    ///   - decoder: JSON decoder to decode stored data.
    /// - Returns: Single of specified model type.
    func object<T: Decodable>(forKey key: String, decoder: JSONDecoder = JSONDecoder()) -> Single<T> {
        .deferredJust { try self.base.object(forKey: key, decoder: decoder) }
    }

    /// Reactive version of object<T>(forKey:defaultValue:decoder:) -> T.
    ///
    /// - Parameters:
    ///   - key: A key in the current user's defaults database.
    ///   - defaultValue: A default value which will be used if there is no such value for specified key,
    /// or if error occurred during mapping
    ///   - decoder: JSON decoder to decode stored data.
    /// - Returns: Single of specified model type.
    func object<T: Decodable>(forKey key: String, defaultValue: T, decoder: JSONDecoder = JSONDecoder()) -> Single<T> {
        .deferredJust { self.base.object(forKey: key, defaultValue: defaultValue, decoder: decoder) }
    }

    /// Reactive version of set<T>(object:forKey:encoder:).
    ///
    /// - Parameters:
    ///   - object: The object with specified type to store in the defaults database.
    ///   - key: The key with which to associate with the value.
    ///   - encoder: JSON encoder to encode to encode passed object.
    /// - Returns: Completable.
    func set<T: Encodable>(object: T?, forKey key: String, encoder: JSONEncoder = JSONEncoder()) -> Completable {
        .deferredJust {
            try self.base.set(object: object, forKey: key, encoder: encoder)
        }
    }
}
