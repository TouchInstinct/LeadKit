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

import Alamofire
import Foundation

public extension EndpointRequest {
    func serialize<Serializer: BodySerializer>(using serializer: Serializer) throws -> SerializedRequest where Serializer.Body == Body {
        let baseUrl = try server.url(using: customServerVariables)
        let path = PathParameterEncoding(templateUrl: templatePath).encode(parameters: pathParameters)
        let (contentType, bodyData) = try serializer.serialize(body: body)
        let queryParameters = QueryStringParameterEncoding().encode(parameters: queryParameters)

        var headerParameters = headerParameters ?? HTTPHeaders()
        headerParameters.add(.contentType(contentType))

        let cookies: [HTTPCookie]

        if let domain = baseUrl.host {
            cookies = cookieParameters.compactMap { key, value in
                HTTPCookie(properties: [
                    .name : key,
                    .value: value,
                    .domain: domain,
                    .path: path
                ])
            }
        } else {
            cookies = []
        }

        return SerializedRequest(baseURL: baseUrl,
                                 path: path,
                                 method: method,
                                 bodyData: bodyData,
                                 queryParameters: queryParameters,
                                 headers: headerParameters.dictionary,
                                 cookies: cookies,
                                 acceptableStatusCodes: acceptableStatusCodes)
    }
}

