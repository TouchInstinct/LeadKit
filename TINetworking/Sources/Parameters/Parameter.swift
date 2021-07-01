public struct Parameter<Location: ParameterLocation> {
    public let value: Any
    public let allowEmptyValue: Bool

    public init(value: Any, allowEmptyValue: Bool = false) {
        self.value = value
        self.allowEmptyValue = allowEmptyValue
    }
}
