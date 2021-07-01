import Foundation

public struct TextPlainResponseContent: ResponseContent {
    struct UnableToDecodeStringError: Error {
        let data: Data
        let encoding: String.Encoding
    }

    private let encoding: String.Encoding

    public init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding
    }

    public let mediaTypeName = MediaType.textPlain.rawValue

    public func decodeResponse(data: Data) throws -> String {
        guard let plainText = String(data: data, encoding: encoding) else {
            throw UnableToDecodeStringError(data: data, encoding: encoding)
        }

        return plainText
    }
}
