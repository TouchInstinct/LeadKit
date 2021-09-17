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
