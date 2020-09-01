//
//  Copyright (c) 2018 Touch Instinct
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

/// Session Manager stored in NetworkService
open class SessionManager: Alamofire.Session {

    /// Response with HTTP URL Response and target object
    public typealias ModelResponse<T> = (response: HTTPURLResponse, model: T)

    /// Response with HTTP URL Response and data
    public typealias DataResponse = (response: HTTPURLResponse, data: Data)

    /// Acceptable status codes for validation
    public let acceptableStatusCodes: Set<Int>

    /// Dispatch Queue on which mapping is performed
    public let mappingQueue: DispatchQueue

    public init(configuration: URLSessionConfiguration,
                serverTrustManager: ServerTrustManager,
                acceptableStatusCodes: Set<Int>,
                mappingQueue: DispatchQueue) {

        self.acceptableStatusCodes = acceptableStatusCodes
        self.mappingQueue = mappingQueue
        
        let delegate = SessionDelegate()
        
        let delegateQueue = OperationQueue()

        let queue = DispatchQueue(label: "org.alamofire.session.rootQueue")
        delegateQueue.underlyingQueue = queue

        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: delegateQueue)

        super.init(session: session,
                   delegate: delegate,
                   rootQueue: queue,
                   serverTrustManager: serverTrustManager)
    }

    public init?(session: URLSession,
                 delegate: SessionDelegate,
                 serverTrustManager: ServerTrustManager,
                 acceptableStatusCodes: Set<Int>,
                 mappingQueue: DispatchQueue) {

        self.acceptableStatusCodes = acceptableStatusCodes
        self.mappingQueue = mappingQueue
        
        let queue = DispatchQueue(label: "org.alamofire.session.rootQueue")
        session.delegateQueue.underlyingQueue = queue

        super.init(session: session,
                   delegate: delegate,
                   rootQueue: queue,
                   serverTrustManager: serverTrustManager)
    }
}
