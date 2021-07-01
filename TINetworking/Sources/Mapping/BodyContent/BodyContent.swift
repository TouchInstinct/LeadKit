import Foundation

public protocol BodyContent: Content {
    func encodeBody() throws -> Data
}
