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

        try date(from: try decode(String.self, forKey: key),
                 forKey: key,
                 using: dateFormatter)
    }

    func decodeDate(forKey key: Key,
                    using dateFormatter: DateFormatter,
                    required: Bool) throws -> Date? {

        guard let stringDate = try decode(String?.self, forKey: key, required: required) else {
            return nil
        }

        return try date(from: stringDate,
                        forKey: key,
                        using: dateFormatter)
    }

    func decodeDate(forKey key: Key,
                    using dateFormatter: ISO8601DateFormatter) throws -> Date {

        try date(from: try decode(String.self, forKey: key),
                 forKey: key,
                 using: dateFormatter)
    }

    func decodeDate(forKey key: Key,
                    using dateFormatter: ISO8601DateFormatter,
                    required: Bool) throws -> Date? {

        guard let stringDate = try decode(String?.self, forKey: key, required: required) else {
            return nil
        }

        return try date(from: stringDate,
                        forKey: key,
                        using: dateFormatter)
    }

    private func date(from string: String,
                      forKey key: Key,
                      using dateFormatter: DateFormatter) throws -> Date {

        guard let date = dateFormatter.date(from: string) else {
            let failureReason: String

            if let dateFormat = dateFormatter.dateFormat, !dateFormat.isEmpty {
                failureReason = "Unable to decode date from \(string) using dateFormat \(dateFormat)"
            } else {
                failureReason = "DateFormatter is not configured (dateFormat is nil or empty)"
            }

            throw DecodingError.dataCorruptedError(forKey: key,
                                                   in: self,
                                                   debugDescription: failureReason)
        }

        return date
    }

    private func date(from string: String,
                      forKey key: Key,
                      using dateFormatter: ISO8601DateFormatter) throws -> Date {

        guard let date = dateFormatter.date(from: string) else {
            let failureReason = "Unable to decode date from \(string) using ISO8601 options: \(dateFormatter.formatOptions)"

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

        let formattedDate = try string(from: date, forKey: key, using: dateFormatter)

        try encode(formattedDate, forKey: key)
    }

    mutating func encode(date: Date?,
                         forKey key: Key,
                         using dateFormatter: DateFormatter,
                         required: Bool) throws {

        if let date = date {
            let formattedDate = try string(from: date, forKey: key, using: dateFormatter)

            try encode(formattedDate, forKey: key)
        } else if required {
            try encodeNil(forKey: key)
        }
    }

    mutating func encode(date: Date,
                         forKey key: Key,
                         using dateFormatter: ISO8601DateFormatter) throws {

        try encode(dateFormatter.string(from: date), forKey: key)
    }

    mutating func encode(date: Date?,
                         forKey key: Key,
                         using dateFormatter: ISO8601DateFormatter,
                         required: Bool) throws {

        if let date = date {
            let formattedDate = dateFormatter.string(from: date)

            try encode(formattedDate, forKey: key)
        } else if required {
            try encodeNil(forKey: key)
        }
    }

    private func string(from date: Date,
                        forKey key: Key,
                        using dateFormatter: DateFormatter) throws -> String {

        guard let dateFormat = dateFormatter.dateFormat, !dateFormat.isEmpty else {
            let context = EncodingError.Context(codingPath: codingPath,
                                                debugDescription: "DateFormatter is not configured (dateFormat is nil or empty)",
                                                underlyingError: nil)

            throw EncodingError.invalidValue(date, context)
        }

        return dateFormatter.string(from: date)
    }
}
