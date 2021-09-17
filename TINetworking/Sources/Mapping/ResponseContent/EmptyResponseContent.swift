import Foundation

public final class EmptyResponseContent: BaseContent, ResponseContent {
    public func decodeResponse(data: Data) throws -> Void {
        ()
    }
}
