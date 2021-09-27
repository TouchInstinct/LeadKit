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

public final class TextPlainResponseContent: BaseContent, ResponseContent {
    public struct StringDecodingError: Error {
        let data: Data
        let encoding: String.Encoding
    }

    private let encoding: String.Encoding

    public init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding

        super.init(mediaTypeName: CommonMediaTypes.textPlain.rawValue)
    }

    // MARK: - ResponseContent

    public func decodeResponse(data: Data) throws -> String {
        guard let plainText = String(data: data, encoding: encoding) else {
            throw StringDecodingError(data: data, encoding: encoding)
        }

        return plainText
    }
}
