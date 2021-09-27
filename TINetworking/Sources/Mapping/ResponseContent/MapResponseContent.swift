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
import TISwiftUtils

public struct MapResponseContent<Model>: ResponseContent {
    private let decodeClosure: ThrowableClosure<Data, Model>

    public let mediaTypeName: String

    public init<C: ResponseContent>(responseContent: C, transform: @escaping Closure<C.Model, Model>) {
        mediaTypeName = responseContent.mediaTypeName
        decodeClosure = {
            transform(try responseContent.decodeResponse(data: $0))
        }
    }

    public func decodeResponse(data: Data) throws -> Model {
        try decodeClosure(data)
    }
}

public extension ResponseContent {
    typealias TransformClosure<T> = Closure<Model, T>

    func map<R>(_ transform: @escaping TransformClosure<R>) -> MapResponseContent<R> {
        .init(responseContent: self, transform: transform)
    }
}

public extension JSONDecoder {
    func responseContent<T: Decodable, R>(_ tranfsorm: @escaping Closure<T, R>) -> MapResponseContent<R> {
        responseContent().map(tranfsorm)
    }

    func decoding<T: Decodable, R>(to tranfsorm: @escaping Closure<T, R>) -> ThrowableClosure<Data, R> {
        responseContent(tranfsorm).decodeResponse
    }
}
