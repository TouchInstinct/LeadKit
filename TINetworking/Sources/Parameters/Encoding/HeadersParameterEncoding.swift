open class HeadersParameterEncoding: BaseUrlParameterEncoding, ParameterEncoding {
    public let sequenceSeparator: String

    public init(sequenceSeparator: String = ";") {
        self.sequenceSeparator = sequenceSeparator
    }

    open func encode(parameters: [String: Parameter<LocationHeader>]) -> [String: String] {
        Dictionary(encode(parameters: parameters)) {
            $0 + sequenceSeparator + $1
        }
    }
}
