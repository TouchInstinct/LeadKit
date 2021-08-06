open class HeadersParameterEncoding {
    public let sequenceSeparator: String

    public init(sequenceSeparator: String = ";") {
        self.sequenceSeparator = sequenceSeparator
    }

    open func encode(parameters: [KeyValueTuple<String, String>]) -> [String: String] {
        Dictionary(parameters) {
            $0 + sequenceSeparator + $1
        }
    }
}
