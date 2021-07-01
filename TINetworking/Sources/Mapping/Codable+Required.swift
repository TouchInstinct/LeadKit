public extension KeyedDecodingContainer {
    func decode<T: Decodable>(_ type: T?.Type,
                              forKey key: Key,
                              required: Bool) throws -> T? {

        required ? try decode(type, forKey: key) : try decodeIfPresent(T.self, forKey: key)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode<T: Encodable>(_ value: T?,
                                       forKey key: Key,
                                       required: Bool) throws {

        if let value = value {
            try encode(value, forKey: key)
        } else if required {
            try encodeNil(forKey: key)
        }
    }
}
