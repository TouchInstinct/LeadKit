public struct OneOfMappingError: Error, CustomDebugStringConvertible {
    public typealias MappingFailures = [KeyValueTuple<Any.Type, Error>]

    public let codingPath: [CodingKey]
    public let mappingFailures: MappingFailures

    public init(codingPath: [CodingKey], mappingFailures: MappingFailures) {
        self.codingPath = codingPath
        self.mappingFailures = mappingFailures
    }

    public var debugDescription: String {
        var formattedString = "\"oneOf\" mapping failed for codingPath \(codingPath)\nwith following errors:\n"

        for (type, error) in mappingFailures {
            formattedString += "\(type) mapping failed with error: \(error)\n"
        }

        return formattedString
    }
}
