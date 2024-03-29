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

import Foundation

public struct WebViewJSError: WebViewError, Codable {

    public enum CodingKeys: String, CodingKey {
        case sourceURL
        case name
        case message
        case lineNumber = "line"
        case columnNumber = "column"
        case stackTrace = "stack"
    }

    public let sourceURL: URL?
    public let name: String?
    public let message: String?
    public let lineNumber: Int?
    public let columnNumber: Int?
    public let stackTrace: String?

    public init(sourceURL: String?,
                name: String?,
                message: String?,
                lineNumber: Int?,
                columnNumber: Int?,
                stackTrace: String?) {

        if let sourceURL = sourceURL {
            self.sourceURL = URL(string: sourceURL)
        } else {
            self.sourceURL = nil
        }

        self.name = name
        self.message = message
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
        self.stackTrace = stackTrace
    }

    public init?(from json: [String: Any], jsonDecoder: JSONDecoder = .init()) {
        guard let data = try? JSONSerialization.data(withJSONObject: json),
              let error = try? jsonDecoder.decode(WebViewJSError.self, from: data) else {
            return nil
        }

        self = error
    }
}
