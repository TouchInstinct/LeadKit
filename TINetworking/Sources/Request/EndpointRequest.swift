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

public struct EndpointRequest<Body, SuccessResponse> {
    public var templatePath: String
    public var method: HTTPMethod
    public var body: Body
    public var queryParameters: [String: Parameter<LocationQuery>]
    public var pathParameters: [String: Parameter<LocationPath>]
    public var headerParameters: HTTPHeaders?
    public var cookieParameters: [String: Parameter<LocationCookie>]
    public var acceptableStatusCodes: Set<Int>
    public var server: Server
    public var customServerVariables: [KeyValueTuple<String, String>]

    public init(templatePath: String,
                method: HTTPMethod,
                body: Body,
                queryParameters: [String: Parameter<LocationQuery>] = [:],
                pathParameters: [String: Parameter<LocationPath>] = [:],
                headerParameters: HTTPHeaders? = nil,
                cookieParameters: [String: Parameter<LocationCookie>] = [:],
                acceptableStatusCodes: Set<Int> = HTTPCodes.success.asSet(),
                server: Server,
                customServerVariables: [KeyValueTuple<String, String>] = []) {

        self.templatePath = templatePath
        self.method = method
        self.body = body
        self.queryParameters = queryParameters
        self.pathParameters = pathParameters
        self.headerParameters = headerParameters
        self.cookieParameters = cookieParameters
        self.acceptableStatusCodes = acceptableStatusCodes
        self.server = server
        self.customServerVariables = customServerVariables
    }
}
