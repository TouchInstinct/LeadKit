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
    func decodeDate<Format: DateFormat>(forKey key: Key,
                                        userInfo: [CodingUserInfoKey: Any],
                                        dateFormat: Format) throws -> Date {
        
        try date(from: try decode(String.self, forKey: key),
                 forKey: key,
                 using: try userInfo.dateFormatter(for: dateFormat))
    }
    
    func decodeDate<Format: DateFormat>(forKey key: Key,
                                        userInfo: [CodingUserInfoKey: Any],
                                        dateFormat: Format) throws -> [Date] {
        
        let dateFormatter = try userInfo.dateFormatter(for: dateFormat)
        
        return try decode([String].self, forKey: key).map {
            try date(from: $0,
                     forKey: key,
                     using: dateFormatter)
        }
    }
    
    // MARK: - Optional variants
    
    func decodeDate<Format: DateFormat>(forKey key: Key,
                                        userInfo: [CodingUserInfoKey: Any],
                                        dateFormat: Format,
                                        required: Bool) throws -> Date? {
        
        guard let stringDate = try decode(String?.self, forKey: key, required: required) else {
            return nil
        }
        
        return try date(from: stringDate,
                        forKey: key,
                        using: try userInfo.dateFormatter(for: dateFormat))
    }
    
    func decodeDate<Format: DateFormat>(forKey key: Key,
                                        userInfo: [CodingUserInfoKey: Any],
                                        dateFormat: Format,
                                        required: Bool) throws -> [Date]? {
        
        guard let stringDates = try decode([String]?.self, forKey: key, required: required) else {
            return nil
        }
        
        let dateFormatter = try userInfo.dateFormatter(for: dateFormat)
        
        return try stringDates.map {
            try date(from: $0,
                     forKey: key,
                     using: dateFormatter)
        }
    }
    
    // MARK: - Private
    
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
}

// ISO8601

public extension KeyedDecodingContainer {
    func decodeDate(forKey key: Key,
                    userInfo: [CodingUserInfoKey: Any],
                    options formatOptions: ISO8601DateFormatter.Options) throws -> Date {
        
        try decodeDate(from: try decode(String.self, forKey: key),
                       forKey: key,
                       userInfo: userInfo,
                       options: formatOptions)
    }
    
    func decodeDates(forKey key: Key,
                     userInfo: [CodingUserInfoKey: Any],
                     options formatOptions: ISO8601DateFormatter.Options) throws -> [Date] {
        
        try decodeDates(from: try decode([String].self, forKey: key),
                        forKey: key,
                        userInfo: userInfo,
                        options: formatOptions)
    }
    
    // MARK: - Optional variants
    
    func decodeDate(forKey key: Key,
                    userInfo: [CodingUserInfoKey: Any],
                    options formatOptions: ISO8601DateFormatter.Options,
                    required: Bool) throws -> Date? {
        
        guard let stringDate = try decode(String?.self, forKey: key, required: required) else {
            return nil
        }
        
        return try decodeDate(from: stringDate,
                              forKey: key,
                              userInfo: userInfo,
                              options: formatOptions)
    }
    
    func decodeDates(forKey key: Key,
                     userInfo: [CodingUserInfoKey: Any],
                     options formatOptions: ISO8601DateFormatter.Options,
                     required: Bool) throws -> [Date]? {
        
        guard let stringDates = try decode([String]?.self, forKey: key, required: required) else {
            return nil
        }
        
        return try decodeDates(from: stringDates,
                               forKey: key,
                               userInfo: userInfo,
                               options: formatOptions)
    }
    
    // MARK: - Private
    
    private func decodeDate(from string: String,
                            forKey key: Key,
                            userInfo: [CodingUserInfoKey: Any],
                            options formatOptions: ISO8601DateFormatter.Options) throws -> Date {
        
        try decodeDate(from: string,
                       forKey: key,
                       using: try userInfo.iso8601DateFormatter(for: formatOptions),
                       fractionalSecondsDateFormatter: try? userInfo.iso8601DateFormatter(for: .withInternetDateTime.union(.withFractionalSeconds)))
    }
    
    private func decodeDates(from dateStrings: [String],
                             forKey key: Key,
                             userInfo: [CodingUserInfoKey: Any],
                             options formatOptions: ISO8601DateFormatter.Options) throws -> [Date] {
        
        let dateFormatter = try userInfo.iso8601DateFormatter(for: formatOptions)
        let fractionalSecondsDateFormatter = try? userInfo.iso8601DateFormatter(for: .withInternetDateTime.union(.withFractionalSeconds))
        
        return try dateStrings.map {
            try decodeDate(from: $0,
                           forKey: key,
                           using: dateFormatter,
                           fractionalSecondsDateFormatter: fractionalSecondsDateFormatter)
        }
    }
    
    private func decodeDate(from string: String,
                            forKey key: Key,
                            using dateFormatter: ISO8601DateFormatter,
                            fractionalSecondsDateFormatter: ISO8601DateFormatter?) throws -> Date {
        
        do {
            return try date(from: string,
                            forKey: key,
                            using: dateFormatter)
        } catch let dateDecodingError as DecodingError {
            if case .dataCorrupted = dateDecodingError,
               dateFormatter.formatOptions == .withInternetDateTime,
               let fractionalSecondsDateFormatter = fractionalSecondsDateFormatter {
                do {
                    return try date(from: string,
                                    forKey: key,
                                    using: fractionalSecondsDateFormatter)
                } catch {
                    let failureReason = "Unable to decode date from \(string). Tried ISO8601 options: \(dateFormatter.formatOptions), \(fractionalSecondsDateFormatter.formatOptions)"
                    
                    throw DecodingError.dataCorruptedError(forKey: key,
                                                           in: self,
                                                           debugDescription: failureReason)
                }
            } else {
                throw dateDecodingError // rethrow
            }
        }
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
