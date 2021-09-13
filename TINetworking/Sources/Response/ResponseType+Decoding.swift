import Foundation

public typealias StatusCodeMimeType = (statusCode: Int, mimeType: String?)
public typealias StatusCodesMimeType = (statusCodes: Set<Int>, mimeType: String?)

public extension ResponseType {
    typealias DecodingClosure<R> = (Data) throws -> R

    func decode<R>(mapping: [KeyValueTuple<StatusCodeMimeType, DecodingClosure<R>>]) -> Result<R, ErrorType> {
        for ((mappingStatusCode, mappingMimeType), decodeClosure) in mapping
        where mappingStatusCode == statusCode && mappingMimeType == mimeType {
            do {
                return .success(try decodeClosure(data))
            } catch {
                return .failure(objectMappingError(underlyingError: error))
            }
        }

        guard mapping.contains(where: { $0.key.statusCode == statusCode }) else {
            return .failure(unsupportedStatusCodeError(statusCode: statusCode))
        }

        guard mapping.contains(where: { $0.key.mimeType == mimeType }) else {
            return .failure(unsupportedMimeTypeError(mimeType: mimeType))
        }

        return .failure(unsupportedStatusCodeMimeTypePairError(statusCode: statusCode, mimeType: mimeType))
    }

    func decode<R>(mapping: [KeyValueTuple<StatusCodesMimeType, DecodingClosure<R>>]) -> Result<R, ErrorType> {
        decode(mapping: mapping.map { key, value in
            key.statusCodes.map { KeyValueTuple(StatusCodeMimeType($0, key.mimeType), value) }
        }.flatMap { $0 })
    }
}
