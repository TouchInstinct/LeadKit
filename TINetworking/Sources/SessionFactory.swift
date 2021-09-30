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
import Alamofire

open class SessionFactory {

    public var timeoutInterval: TimeInterval
    public var additionalHttpHeaders: HTTPHeaders
    public var serverTrustPolicies: [String: ServerTrustEvaluating]

    public init(timeoutInterval: TimeInterval = 20,
                additionalHttpHeaders: HTTPHeaders = HTTPHeaders(),
                trustPolicies: [String: ServerTrustEvaluating] = [:]) {

        self.timeoutInterval = timeoutInterval
        self.additionalHttpHeaders = additionalHttpHeaders
        self.serverTrustPolicies = Dictionary(uniqueKeysWithValues: trustPolicies.map { ($0.key.urlHost, $0.value) })
    }

    open func createSession() -> Session {
        Session(configuration: createSessionConfiguration(),
                serverTrustManager: ServerTrustManager(allHostsMustBeEvaluated: false,
                                                       evaluators: serverTrustPolicies))
    }

    open func createSessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = timeoutInterval
        sessionConfiguration.httpAdditionalHeaders = additionalHttpHeaders.dictionary

        return sessionConfiguration
    }
}
