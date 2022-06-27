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

open class DefaultSecuritySchemePreprocessor: SecuritySchemePreprocessor {
    struct ValueNotProvidedError: Error {}

    public typealias ValueProvider = () -> String?

    private let valueProvider: ValueProvider

    public init(valueProvider: @escaping ValueProvider) {
        self.valueProvider = valueProvider
    }

    public init(staticValue: String?) {
        self.valueProvider = { staticValue }
    }

    // MARK: - EndpointSecurityRequestPreprocessor

    public func preprocess<B, S>(request: EndpointRequest<B, S>, using security: SecurityScheme) throws -> EndpointRequest<B, S> {
        var modifiedRequest = request

        guard let value = valueProvider() else {
            throw ValueNotProvidedError()
        }

        switch security {
        case let .http(authenticationScheme):
            let headerValue = "\(authenticationScheme.rawValue) \(value)"
            var headerParameters = modifiedRequest.headerParameters ?? [:]
            headerParameters.updateValue(.init(value: headerValue),
                                         forKey: "Authorization")

            modifiedRequest.headerParameters = headerParameters
        case let .apiKey(parameterLocation, parameterName):
            switch parameterLocation {
            case .header:
                var headerParameters = modifiedRequest.headerParameters ?? [:]
                headerParameters.updateValue(.init(value: value),
                                             forKey: parameterName)

                modifiedRequest.headerParameters = headerParameters
            case .query:
                modifiedRequest.queryParameters.updateValue(.init(value: value),
                                                            forKey: parameterName)
            case .cookie:
                modifiedRequest.cookieParameters.updateValue(.init(value: value),
                                                             forKey: parameterName)
            }
        }

        return modifiedRequest
    }
}
