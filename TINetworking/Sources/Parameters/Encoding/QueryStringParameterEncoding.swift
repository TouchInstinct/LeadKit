open class QueryStringParameterEncoding: BaseUrlParameterEncoding, ParameterEncoding {
    open func encode(parameters: [String: Parameter<LocationQuery>]) -> [String: Any] {
        let includedKeys = Set(super.encode(parameters: parameters).map { $0.key })

        return parameters
            .filter { includedKeys.contains($0.key) }
            .mapValues { $0.value }
    }
}
