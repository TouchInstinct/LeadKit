//
//  Copyright (c) 2021 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

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

    private var defaultVariables: [KeyValueTuple<String, String>] {
        variables.map { ($0.key, $0.value.defaultValue) }
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

    public func url(using variables: [KeyValueTuple<String, String>] = [],
                    appendHttpsSchemeIfMissing: Bool = true) throws -> URL {

        guard !variables.isEmpty else {
            return try String.render(template: urlTemplate, using: defaultVariables).asURL()
        }

        let defaultVariablesToApply = self.defaultVariables
            .filter { (key, _) in variables.contains { $0.key == key } }

        let defaultParametersTemplate = String.render(template: urlTemplate,
                                                      using: defaultVariablesToApply)

        let formattedUrlString = String.render(template: defaultParametersTemplate, using: variables)

        if appendHttpsSchemeIfMissing, !formattedUrlString.contains(Scheme.https.urlPrefix) {
            return try (Scheme.https.urlPrefix + formattedUrlString).asURL()
        }

        return try formattedUrlString.asURL()
    }
}
