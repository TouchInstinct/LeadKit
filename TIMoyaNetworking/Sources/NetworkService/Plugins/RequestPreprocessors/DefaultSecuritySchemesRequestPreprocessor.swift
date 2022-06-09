//
//  Copyright (c) 2022 Touch Instinct
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

import TINetworking

open class DefaultEndpointSecurityPreprocessor: EndpointRequestPreprocessor {
    enum PreprocessError: Error {
        case missingSecurityScheme(String, [String: SecurityScheme])
        case unableToSatisfyRequirements(anyOfRequired: [[String]],
                                         registeredPreprocessors: [String: SecuritySchemePreprocessor])
    }

    private let openApi: OpenAPI

    private var schemePreprocessors: [String: SecuritySchemePreprocessor]

    public init(openApi: OpenAPI, schemePreprocessors: [String: SecuritySchemePreprocessor] = [:]) {
        self.openApi = openApi
        self.schemePreprocessors = schemePreprocessors
    }

    public func preprocess<B, S>(request: EndpointRequest<B, S>) throws -> EndpointRequest<B, S> {
        guard !request.security.compactMap({ $0 }).isEmpty else {
            return request
        }

        let endpointSchemes: [[KeyValueTuple<String, SecurityScheme>]] = try request.security.map {
            try $0.map {
                guard let securityScheme = openApi.security[$0] else {
                    throw PreprocessError.missingSecurityScheme($0, openApi.security)
                }

                return ($0, securityScheme)
            }
        }

        for schemeGroup in endpointSchemes {
            let preprocessorsGroup: [KeyValueTuple<SecurityScheme, SecuritySchemePreprocessor>] = schemeGroup.compactMap {
                guard let preprocessor = schemePreprocessors[$0.key] else {
                    return nil
                }

                return ($0.value, preprocessor)
            }

            guard preprocessorsGroup.count == schemeGroup.count else {
                continue // unable to satisfy group requirement
            }

            do {
                return try preprocessorsGroup.reduce(request) {
                    try $1.value.preprocess(request: $0, using: $1.key)
                }
            }
        }

        throw PreprocessError.unableToSatisfyRequirements(anyOfRequired: request.security,
                                                          registeredPreprocessors: schemePreprocessors)
    }

    public func register(preprocessor: SecuritySchemePreprocessor, for scheme: String) {
        schemePreprocessors[scheme] = preprocessor
    }
}
