public struct ResponseTypeDecodingError: Error {
    public let statusCode: Int
    public let contentType: String
}

public struct ContentMapping<Content: ResponseContent> {
    public let statusCode: Int
    public let mimeType: String?
    public let responseContent: Content

    public init(statusCode: Int, mimeType: String?, responseContent: Content) {
        self.statusCode = statusCode
        self.mimeType = mimeType
        self.responseContent = responseContent
    }

    public func map<NewModel>(transform: @escaping (Content.Model) -> NewModel) -> ContentMapping<MapResponseContent<NewModel>> {
        .init(statusCode: statusCode,
              mimeType: mimeType,
              responseContent: MapResponseContent(responseContent: responseContent,
                                                  transform: transform))
    }
}

public extension ResponseType {
    func decode<C>(contentMapping: [ContentMapping<C>]) -> Result<C.Model, ErrorType> {
        for mapping in contentMapping where mapping.statusCode == statusCode && mapping.mimeType == mimeType {
            do {
                return .success(try mapping.responseContent.decodeResponse(data: data))
            } catch {
                return .failure(objectMappingError(underlyingError: error))
            }
        }

        guard contentMapping.contains(where: { $0.statusCode == statusCode }) else {
            return .failure(unsupportedStatusCodeError(statusCode: statusCode))
        }

        guard contentMapping.contains(where: { $0.mimeType == mimeType }) else {
            return .failure(unsupportedMimeTypeError(mimeType: mimeType))
        }

        return .failure(unsupportedStatusCodeMimeTypePairError(statusCode: statusCode, mimeType: mimeType))
    }
}
