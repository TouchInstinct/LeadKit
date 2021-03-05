//
//  Copyright (c) 2018 Touch Instinct
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

import Alamofire

public struct NetworkServiceConfiguration {

    /// Base api url string.
    public let baseUrl: String

    /// Timeout interval for requests.
    public let timeoutInterval: TimeInterval

    /// Default parameters encoding
    public let encoding: ParameterEncoding

    /// A dictionary of additional headers to send with requests.
    public let additionalHttpHeaders: HTTPHeaders

    /// Server trust policies.
    public var serverTrustPolicies: [String: ServerTrustEvaluating]

    /// HTTP response status codes regarded as non-erroneous
    public var acceptableStatusCodes: Set<Int> = Set(200..<300)

    /// Session configuration for potential fine tuning
    public var sessionConfiguration: URLSessionConfiguration

    public init(baseUrl: String,
                timeoutInterval: TimeInterval = 20,
                encoding: ParameterEncoding = URLEncoding.default,
                additionalHttpHeaders: [String: String] = [:],
                trustPolicies: [String: ServerTrustEvaluating] = [:]) {

        self.baseUrl = baseUrl
        self.timeoutInterval = timeoutInterval
        self.encoding = encoding
        self.additionalHttpHeaders = HTTPHeaders(additionalHttpHeaders)

        sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = timeoutInterval
        sessionConfiguration.httpAdditionalHeaders = additionalHttpHeaders

        serverTrustPolicies = Dictionary(uniqueKeysWithValues: trustPolicies.map { ($0.key.asHost, $0.value) })
    }
}

public extension NetworkServiceConfiguration {

    /// SessionManager constructed with given parameters (session configuration and trust policies)
    var sessionManager: SessionManager {
        SessionManager(configuration: sessionConfiguration,
                       serverTrustManager: ServerTrustManager(allHostsMustBeEvaluated: false,
                                                              evaluators: serverTrustPolicies),
                       acceptableStatusCodes: acceptableStatusCodes,
                       mappingQueue: DispatchQueue(label: .mappingQueueLabel, qos: .default))
    }

    /// Convenient method to create ApiRequestParameters.
    ///
    /// - Parameters:
    ///   - relativeUrl: Url that will be concatenated with base url.
    ///   - method: HTTP method to use for request.
    ///   - parameters: Dictionary of parameters to apply to a URLRequest.
    ///   - queryItems: An array of query items to configure URL with them.
    ///   - requestEncoding: Encoding type to use. If passed nil, configuration encoding will be used.
    ///   - requestHeaders: Dictionary of headers to apply to a URLRequest.
    /// - Returns: Initialized instance of ApiRequestParameters with given parameters.
    func apiRequestParameters(relativeUrl: String,
                              method: HTTPMethod = .get,
                              parameters: Parameters? = nil,
                              queryItems: [URLQueryItem]? = nil,
                              requestEncoding: ParameterEncoding? = nil,
                              requestHeaders: HTTPHeaders? = nil) -> ApiRequestParameters {
        ApiRequestParameters(url: baseUrl + relativeUrl,
                             method: method,
                             parameters: parameters,
                             queryItems: queryItems,
                             encoding: requestEncoding ?? encoding,
                             headers: requestHeaders)
    }

    /// Convenient method to create ApiRequestParameters.
    ///
    /// - Parameters:
    ///   - relativeUrl: Url that will be concatenated with base url.
    ///   - method: HTTP method to use for request.
    ///   - parameters: An array of JSON objects to apply to a URLRequest.
    ///   - queryItems: An array of query items to configure URL with them.
    ///   - requestEncoding: Encoding type to use. If passed nil, configuration encoding will be used.
    ///   - requestHeaders: Dictionary of headers to apply to a URLRequest.
    /// - Returns: Initialized instance of ApiRequestParameters with given parameters.
    func apiRequestParameters(relativeUrl: String,
                              method: HTTPMethod = .get,
                              parameters: [Any]? = nil,
                              queryItems: [URLQueryItem]? = nil,
                              requestEncoding: ParameterEncoding? = nil,
                              requestHeaders: HTTPHeaders? = nil) -> ApiRequestParameters {
        ApiRequestParameters(url: baseUrl + relativeUrl,
                             method: method,
                             parameters: parameters,
                             queryItems: queryItems,
                             encoding: requestEncoding ?? encoding,
                             headers: requestHeaders)
    }
}

private extension String {
    static let mappingQueueLabel = "leadkit.session.rootQueue"
}
