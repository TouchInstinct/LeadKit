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

public extension KeyedDecodingContainer {
    func decodeDate(forKey key: Key,
                    using dateFormatter: DateFormatter) throws -> Date {

        let stringDate = try decode(String.self, forKey: key)

        guard let date = dateFormatter.date(from: stringDate) else {
            let failureReason: String

            if let dateFormat = dateFormatter.dateFormat, !dateFormat.isEmpty {
                failureReason = "Unable to decode date from \(stringDate) using dateFormat \(dateFormat)"
            } else {
                failureReason = "DateFormatter is not configured (dateFormat is nil or empty)"
            }

            throw DecodingError.dataCorruptedError(forKey: key,
                                                   in: self,
                                                   debugDescription: failureReason)
        }

        return date
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(date: Date,
                         forKey key: Key,
                         using dateFormatter: DateFormatter) throws {

        guard let dateFormat = dateFormatter.dateFormat, !dateFormat.isEmpty else {
            let context = EncodingError.Context(codingPath: codingPath,
                                                debugDescription: "DateFormatter is not configured (dateFormat is nil or empty)",
                                                underlyingError: nil)

            throw EncodingError.invalidValue(date, context)
        }

        let formattedDate = dateFormatter.string(from: date)

        try encode(formattedDate, forKey: key)
    }
}
