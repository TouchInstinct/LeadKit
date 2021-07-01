import Alamofire

open class BaseUrlParameterEncoding {
    private let encoding: URLEncoding = .queryString

    public init() {
    }

    open func encode<L: ParameterLocation>(parameters: [String: Parameter<L>]) -> [KeyValueTuple<String, String>] {
        var filteredComponents: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            guard let parameter = parameters[key] else {
                continue
            }

            let components: [KeyValueTuple<String, String>] = encoding.queryComponents(fromKey: key, value: parameter.value)

            for component in components {
                if component.value.isEmpty && !parameter.allowEmptyValue {
                    continue
                }

                filteredComponents.append(component)
            }
        }

        return filteredComponents
    }
}
