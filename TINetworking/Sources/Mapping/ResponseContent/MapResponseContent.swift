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
