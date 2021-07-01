import Foundation

public protocol ResponseType {
    associatedtype ErrorType: Error

    var statusCode: Int { get }
    var data: Data { get }
    var mimeType: String? { get }

    func unsupportedStatusCodeError(statusCode: Int) -> ErrorType
    func unsupportedMimeTypeError(mimeType: String?) -> ErrorType
    func objectMappingError(underlyingError: Error) -> ErrorType
    func unsupportedStatusCodeMimeTypePairError(statusCode: Int, mimeType: String?) -> ErrorType
}
