open class MimeTypeUnsupportedError: Error, CustomDebugStringConvertible {

    public let mimeType: String?

    // MARK: - CustomDebugStringConvertible

    public var debugDescription: String {
        "Mime type \(mimeType.debugDescription) isn't supported."
    }

    public init(mimeType: String?) {
        self.mimeType = mimeType
    }
}
