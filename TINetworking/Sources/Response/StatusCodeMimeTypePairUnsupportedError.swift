open class StatusCodeMimeTypePairUnsupportedError: MimeTypeUnsupportedError {

    public let statusCode: Int

    public init(statusCode: Int, mimeType: String?) {
        self.statusCode = statusCode

        super.init(mimeType: mimeType)
    }

    public override var debugDescription: String {
        "Status code: \(statusCode), mimeType: \(mimeType ?? "nil") pair is unsupported!"
    }
}
