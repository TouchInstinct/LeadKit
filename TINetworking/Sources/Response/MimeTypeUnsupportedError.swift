open class MimeTypeUnsupportedError: Error, CustomDebugStringConvertible {

    public let mimeType: String?

    public init(mimeType: String?) {
        self.mimeType = mimeType
    }

    public var debugDescription: String {
        "Mime type \(mimeType.debugDescription) isn't supported."
    }
}
