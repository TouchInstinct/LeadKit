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

import Foundation
import Alamofire

public struct SerializedRequest {
    public var baseURL: URL
    public var path: String
    public var method: HTTPMethod
    public var bodyData: Data
    public var queryParameters: Parameters
    public var headers: [String: String]?
    public var cookies: [HTTPCookie]
    public var acceptableStatusCodes: Set<Int>

    public init(baseURL: URL,
                path: String,
                method: HTTPMethod,
                bodyData: Data,
                queryParameters: Parameters,
                headers: [String: String]?,
                cookies: [HTTPCookie],
                acceptableStatusCodes: Set<Int>) {

        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.bodyData = bodyData
        self.queryParameters = queryParameters
        self.headers = headers
        self.cookies = cookies
        self.acceptableStatusCodes = acceptableStatusCodes
    }
}

extension SerializedRequest: Hashable {
    private var comparableQueryParameters: [String: String] {
        queryParameters.mapValues(String.init(describing:))
    }
    
    public static func == (lhs: SerializedRequest, rhs: SerializedRequest) -> Bool {
        lhs.baseURL == rhs.baseURL &&
        lhs.path == rhs.path &&
        lhs.method == rhs.method &&
        lhs.bodyData == rhs.bodyData &&
        lhs.comparableQueryParameters == rhs.comparableQueryParameters &&
        lhs.headers == rhs.headers &&
        lhs.cookies == rhs.cookies &&
        lhs.acceptableStatusCodes == rhs.acceptableStatusCodes
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(baseURL)
        hasher.combine(path)
        hasher.combine(method)
        hasher.combine(bodyData)
        hasher.combine(comparableQueryParameters.keys.sorted())
        hasher.combine(comparableQueryParameters.values.sorted())
        hasher.combine(headers?.keys.sorted() ?? [])
        hasher.combine(headers?.values.sorted() ?? [])
        hasher.combine(cookies)
        hasher.combine(acceptableStatusCodes.sorted())
    }
}
