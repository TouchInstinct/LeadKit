public struct AnyTypeMapping<R> {
    private let mappingClosure: () -> Result<R, Error>

    public let type: Any.Type

    public init<T: Decodable>(decoder: Decoder,
                              transform: @escaping (T) -> R) {

        type = T.self

        mappingClosure = {
            do {
                return .success(transform(try T(from: decoder)))
            } catch {
                return .failure(error)
            }
        }
    }

    public func decode() -> Result<R, Error> {
        mappingClosure()
    }
}
