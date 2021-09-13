import Foundation

public struct MapResponseContent<Model>: ResponseContent {
    public let mediaTypeName: String

    private let decodeClosure: (Data) throws -> Model

    public init<C: ResponseContent>(responseContent: C, transform: @escaping (C.Model) -> Model) {
        self.mediaTypeName = responseContent.mediaTypeName
        self.decodeClosure = {
            transform(try responseContent.decodeResponse(data: $0))
        }
    }

    public func decodeResponse(data: Data) throws -> Model {
        try decodeClosure(data)
    }
}

public extension ResponseContent {
    typealias TransformClosure<T> = (Model) -> T

    func map<R>(_ transform: @escaping TransformClosure<R>) -> MapResponseContent<R> {
        .init(responseContent: self, transform: transform)
    }
}

public extension JSONDecoder {
    func responseContent<T: Decodable, R>(_ tranfsorm: @escaping (T) -> R) -> MapResponseContent<R> {
        responseContent().map(tranfsorm)
    }

    func decoding<T: Decodable, R>(to tranfsorm: @escaping (T) -> R) -> (Data) throws -> R {
        responseContent(tranfsorm).decodeResponse
    }
}
