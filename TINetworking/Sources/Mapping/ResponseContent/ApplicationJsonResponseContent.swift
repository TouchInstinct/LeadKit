import Foundation

open class ApplicationJsonResponseContent<Model: Decodable>: ResponseContent {
    public var mediaTypeName: String {
        CommonMediaTypes.applicationJson.rawValue
    }

    public let jsonDecoder: JSONDecoder

    public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }

    public func decodeResponse(data: Data) throws -> Model {
        try jsonDecoder.decode(Model.self, from: data)
    }
}

public extension JSONDecoder {
    func responseContent<R>() -> ApplicationJsonResponseContent<R> {
        .init(jsonDecoder: self)
    }
}
