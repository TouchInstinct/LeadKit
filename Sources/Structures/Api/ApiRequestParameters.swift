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
 *  Enum which keeps parameters type for request body
 */
public enum ParametersType {
    case dictionary(_ parameter: Parameters?)
    case array(_ array: [Parameters]?)
}

/**
 *  Struct which keeps base parameters required for api request
 */
public struct ApiRequestParameters {

    let method: HTTPMethod
    let url: URLConvertible
    let parameters: ParametersType
    let encoding: ParameterEncoding
    let headers: HTTPHeaders?

    public init(url: URLConvertible,
                method: HTTPMethod = .get,
                parameters: Parameters? = nil,
                encoding: ParameterEncoding = URLEncoding.default,
                headers: HTTPHeaders? = nil) {

        self.method = method
        self.url = url
        self.parameters = .dictionary(parameters)
        self.encoding = encoding
        self.headers = headers
    }
    
    public init(url: URLConvertible,
                method: HTTPMethod = .get,
                parameters: [Parameters]? = nil,
                encoding: ParameterEncoding = URLEncoding.default,
                headers: HTTPHeaders? = nil) {
        
        self.method = method
        self.url = url
        self.parameters = .array(parameters)
        self.encoding = encoding
        self.headers = headers
    }

}
