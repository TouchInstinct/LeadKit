//
//  Copyright (c) 2022 Touch Instinct
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

import Moya
import TINetworking

extension Moya.Response: ResponseType {
    public func unsupportedStatusCodeError(statusCode: Int) -> MoyaError {
        .statusCode(self)
    }

    public func unsupportedMimeTypeError(mimeType: String?) -> MoyaError {
        .objectMapping(MimeTypeUnsupportedError(mimeType: mimeType), self)
    }

    public func objectMappingError(underlyingError: Error) -> MoyaError {
        .objectMapping(underlyingError, self)
    }

    public func unsupportedStatusCodeMimeTypePairError(statusCode: Int, mimeType: String?) -> MoyaError {
        .objectMapping(StatusCodeMimeTypePairUnsupportedError(statusCode: statusCode,
                                                              mimeType: mimeType),
                       self)
    }

    public var mimeType: String? {
        response?.mimeType
    }
}