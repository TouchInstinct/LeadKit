import Foundation

private enum Scheme: String {
    case https

    var urlPrefix: String {
        rawValue + "://"
    }
}

public struct Server {
    public struct Variable {
        public let values: [String]
        public let defaultValue: String

        public init(values: [String], defaultValue: String) {
            self.values = values
            self.defaultValue = defaultValue
        }
    }

    public let urlTemplate: String
    public let variables: [String: Variable]

    public init(urlTemplate: String, variables: [String: Variable]) {
        self.urlTemplate = urlTemplate
        self.variables = variables
    }

    public init(baseUrl: String) {
        self.init(urlTemplate: baseUrl, variables: [:])
    }

    private var defaultVariables: [KeyValueTuple<String, String>] {
        variables.map { ($0.key, $0.value.defaultValue) }
    }

    public func url(using variables: [KeyValueTuple<String, String>] = [],
                    appendHttpsSchemeIfMissing: Bool = true) -> URL? {

        guard !variables.isEmpty else {
            return URL(string: .render(template: urlTemplate, using: defaultVariables))
        }

        let defaultVariablesToApply = self.defaultVariables
            .filter { (key, _) in variables.contains { $0.key == key } }

        let defaultParametersTemplate = String.render(template: urlTemplate,
                                                      using: defaultVariablesToApply)

        let formattedUrlString = String.render(template: defaultParametersTemplate, using: variables)

        if appendHttpsSchemeIfMissing, !formattedUrlString.contains(Scheme.https.urlPrefix) {
            return URL(string: Scheme.https.urlPrefix + formattedUrlString)
        }

        return URL(string: formattedUrlString)
    }
}
