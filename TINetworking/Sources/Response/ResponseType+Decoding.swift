//
//  Copyright (c) 2021 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import TISwiftUtils

public typealias StatusCodeMimeType = (statusCode: Int, mimeType: String?)
public typealias StatusCodesMimeType = (statusCodes: Set<Int>, mimeType: String?)

public typealias DecodingClosure<R> = ThrowableClosure<Data, R>

public extension ResponseType {
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
