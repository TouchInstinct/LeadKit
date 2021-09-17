import Foundation

public struct TextPlainResponseContent: ResponseContent {
    struct StringDecodingError: Error {
        let data: Data
        let encoding: String.Encoding
    }

    private let encoding: String.Encoding

    // MARK: - Content

    public let mediaTypeName = CommonMediaTypes.textPlain.rawValue

    public init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding
    }

    // MARK: - ResponseContent

    public func decodeResponse(data: Data) throws -> String {
        guard let plainText = String(data: data, encoding: encoding) else {
            throw StringDecodingError(data: data, encoding: encoding)
        }

        return plainText
    }
}
