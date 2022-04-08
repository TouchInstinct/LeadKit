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
import Foundation

public struct DecodingErrorSummary: CustomStringConvertible {
    public let url: String
    public let requestMethod: String
    public let statusCode: Int
    public let codingPath: String
    public let jsonValue: String
    public let errorDescription: String

    public let formatter: DecodingErrorSummaryFormatter

    public var description: String {
        formatter.format(summary: self)
    }

    public init(decodingError: DecodingError,
                response: Response,
                formatter: DecodingErrorSummaryFormatter) {

        switch decodingError {
        case let .typeMismatch(_, context):
            self.init(context: context, response: response, formatter: formatter)

        case let .dataCorrupted(context):
            self.init(context: context, response: response, formatter: formatter)

        case let .keyNotFound(_, context):
            self.init(context: context, response: response, formatter: formatter)

        case let .valueNotFound(_, context):
            self.init(context: context, response: response, formatter: formatter)
            
        @unknown default:
            self.init(context: .init(codingPath: [],
                                     debugDescription: ">>UNHANDLED DECODING ERROR CASE<<",
                                     underlyingError: nil),
                      response: response,
                      formatter: formatter)
        }
    }

    public init(context: DecodingError.Context,
                response: Response,
                formatter: DecodingErrorSummaryFormatter) {

        self.url = response.request?.url?.relativePath ?? formatter.missingDataPlaceholder
        self.statusCode = response.statusCode
        self.requestMethod = response.request?.httpMethod ?? formatter.missingDataPlaceholder
        self.codingPath = formatter.format(codingPath: context.codingPath)
        self.errorDescription = context.debugDescription
        self.jsonValue = formatter.format(jsonValue: context.extractJsonValue(from: response))

        self.formatter = formatter
    }
}

private extension DecodingError.Context {
    func extractJsonValue(from response: Response) -> Any? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: response.data, options: .fragmentsAllowed)

            return value(forCodingPath: codingPath, in: jsonObject)
        } catch {
            return nil
        }
    }
}

private func value<C: Collection>(forCodingPath path: C, in obj: Any?) -> Any? where C.Element == CodingKey {
    guard let part = path.first else {
        return obj
    }

    switch obj {
    case let dict as [AnyHashable: Any]:
        return value(forCodingPath: path.dropFirst(), in: dict[part.stringValue])
    case let array as [Any]:
        guard let arrayIndex = part.intValue else {
            return nil
        }

        return value(forCodingPath: path.dropFirst(), in: array[arrayIndex])
    case let anyObj as AnyObject:
        return value(forCodingPath: path.dropFirst(), in: anyObj.value(forKey: part.stringValue))
    default:
        return nil
    }
}
