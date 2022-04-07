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

public extension KeyedEncodingContainer {
    mutating func encode<Format: DateFormat>(date: Date,
                                             forKey key: Key,
                                             userInfo: [CodingUserInfoKey: Any],
                                             dateFormat: Format) throws {

        let dateFormatter = try userInfo.dateFormatter(for: dateFormat)

        try encode(try string(from: date, using: dateFormatter), forKey: key)
    }

    mutating func encode<Format: DateFormat>(dates: [Date],
                                             forKey key: Key,
                                             userInfo: [CodingUserInfoKey: Any],
                                             dateFormat: Format) throws {

        let dateFormatter = try userInfo.dateFormatter(for: dateFormat)

        try encode(dates.map { try string(from: $0, using: dateFormatter) }, forKey: key)
    }

    // MARK: - Optional variants

    mutating func encode<Format: DateFormat>(date: Date?,
                                             forKey key: Key,
                                             userInfo: [CodingUserInfoKey: Any],
                                             dateFormat: Format,
                                             required: Bool) throws {

        if let date = date {
            try encode(date: date, forKey: key, userInfo: userInfo, dateFormat: dateFormat)
        } else if required {
            try encodeNil(forKey: key)
        }
    }

    mutating func encode<Format: DateFormat>(dates: [Date]?,
                                             forKey key: Key,
                                             userInfo: [CodingUserInfoKey: Any],
                                             dateFormat: Format,
                                             required: Bool) throws {

        if let dates = dates {
            try encode(dates: dates, forKey: key, userInfo: userInfo, dateFormat: dateFormat)
        } else if required {
            try encodeNil(forKey: key)
        }
    }

    // MARK: - Private

    private func string(from date: Date,
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

// ISO8601

public extension KeyedEncodingContainer {
    mutating func encode(date: Date,
                         forKey key: Key,
                         userInfo: [CodingUserInfoKey: Any],
                         options formatOptions: ISO8601DateFormatter.Options) throws {

        let dateFormatter = try userInfo.iso8601DateFormatter(for: formatOptions)

        try encode(dateFormatter.string(from: date), forKey: key)
    }

    mutating func encode(dates: [Date],
                         forKey key: Key,
                         userInfo: [CodingUserInfoKey: Any],
                         options formatOptions: ISO8601DateFormatter.Options) throws {

        let dateFormatter = try userInfo.iso8601DateFormatter(for: formatOptions)

        try encode(dates.map { dateFormatter.string(from: $0) }, forKey: key)
    }

    // MARK: - Optional variants

    mutating func encode(date: Date?,
                         forKey key: Key,
                         userInfo: [CodingUserInfoKey: Any],
                         options formatOptions: ISO8601DateFormatter.Options,
                         required: Bool) throws {

        if let date = date {
            try encode(date: date, forKey: key, userInfo: userInfo, options: formatOptions)
        } else if required {
            try encodeNil(forKey: key)
        }
    }

    mutating func encode(dates: [Date]?,
                         forKey key: Key,
                         userInfo: [CodingUserInfoKey: Any],
                         options formatOptions: ISO8601DateFormatter.Options,
                         required: Bool) throws {

        if let dates = dates {
            try encode(dates: dates, forKey: key, userInfo: userInfo, options: formatOptions)
        } else if required {
            try encodeNil(forKey: key)
        }
    }
}
