import Foundation

public final class EmptyBodyContent: BaseContent, BodyContent {
    public func encodeBody() throws -> Data {
        Data()
    }
}

public extension BodyContent {
    static var empty: EmptyBodyContent {
        .init()
    }
}
