import Foundation

open class ApplicationJsonResponseContent<Model: Decodable>: BaseContent, ResponseContent {
    public let jsonDecoder: JSONDecoder

    public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder

        super.init(mediaTypeName: CommonMediaTypes.applicationJson.rawValue)
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
