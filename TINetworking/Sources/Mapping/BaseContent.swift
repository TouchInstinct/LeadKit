import Foundation

open class BaseContent: Content {
    public let mediaTypeName: String

    public init(mediaTypeName: String = CommonMediaTypes.textPlain.rawValue) {
        self.mediaTypeName = mediaTypeName
    }
}
