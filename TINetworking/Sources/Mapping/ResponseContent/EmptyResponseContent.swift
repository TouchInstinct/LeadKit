import Foundation

open class EmptyResponseContent: BaseContent, ResponseContent {
    public func decodeResponse(data: Data) throws -> Void {
        ()
    }
}
