import Foundation

public protocol ResponseContent: Content {
    associatedtype Model

    func decodeResponse(data: Data) throws -> Model
}
