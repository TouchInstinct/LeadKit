import Foundation

public extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }

    var urlHost: String {
        URL(string: self)?.host ?? self
    }

    static func render(template: String, using variables: [KeyValueTuple<String, String>]) -> String {
        variables.reduce(template) {
            $0.replacingOccurrences(of: "{\($1.key)}", with: $1.value.urlEscaped)
        }
    }
}
