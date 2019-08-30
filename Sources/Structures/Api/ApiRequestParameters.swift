//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Alamofire

/**
 *  Struct which keeps base parameters required for api request
 */
public struct ApiRequestParameters {

    /// Enum which keeps parameters type for request body
    ///
    /// - dictionary: dictionary parameter
    /// - array: array parameter
    public enum RequestParameters {
        case dictionary(Parameters)
        case array([Any])
    }

    public let url: URLConvertible
    public let parameters: RequestParameters?
    public let queryItems: [URLQueryItem]?
    public let method: HTTPMethod
    public let encoding: ParameterEncoding
    public let headers: HTTPHeaders?

    public init(url: URLConvertible,
                method: HTTPMethod = .get,
                parameters: Parameters? = nil,
                queryItems: [URLQueryItem]? = nil,
                encoding: ParameterEncoding = URLEncoding.default,
                headers: HTTPHeaders? = nil) {

        self.method = method
        self.url = url
        self.queryItems = queryItems
        self.encoding = encoding
        self.headers = headers
        if let parameters = parameters {
            self.parameters = .dictionary(parameters)
        } else {
            self.parameters = nil
        }
    }

    public init(url: URLConvertible,
                method: HTTPMethod = .get,
                parameters: [Any]? = nil,
                queryItems: [URLQueryItem]? = nil,
                encoding: ParameterEncoding = URLEncoding.default,
                headers: HTTPHeaders? = nil) {

        self.method = method
        self.url = url
        self.queryItems = queryItems
        self.encoding = encoding
        self.headers = headers
        if let parameters = parameters {
            self.parameters = .array(parameters)
        } else {
            self.parameters = nil
        }
    }
}
