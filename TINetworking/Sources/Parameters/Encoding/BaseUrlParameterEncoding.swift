import Alamofire

open class BaseUrlParameterEncoding {
    private let encoding: URLEncoding = .queryString

    public init() {}

    open func encode<L: ParameterLocation>(parameters: [String: Parameter<L>]) -> [KeyValueTuple<String, String>] {
        var filteredComponents: [KeyValueTuple<String, String>] = []

        for key in parameters.keys.sorted(by: <) {
            guard let parameter = parameters[key] else {
                continue
            }

            let components = encoding.queryComponents(fromKey: key, value: parameter.value)
                // filter components with empty values if parameter doesn't allow empty value
                .filter { !$0.1.isEmpty || parameter.allowEmptyValue }

            filteredComponents.append(contentsOf: components)
        }

        return filteredComponents
    }
}
