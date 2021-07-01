import Foundation

public struct EmptyBodyContent: BodyContent {
    public var mediaTypeName: String {
        MediaType.textPlain.rawValue
    }

    public init() {}

    public func encodeBody() throws -> Data {
        Data()
    }
}
