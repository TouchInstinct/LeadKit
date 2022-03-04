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

public extension CodingUserInfoKey {
    static var dateFormattersReusePool: Self? {
        .init(rawValue: "dateFormattersReusePool")
    }
    static var iso8601DateFormattersReusePool: Self? {
        .init(rawValue: "iso8601DateFormattersReusePool")
    }
}

private enum CodingUserInfoError: Error {
    case valueNotFound(CodingUserInfoKey?)
    case typeMismatch(Any.Type, Any.Type)
}

public extension Dictionary where Key == CodingUserInfoKey {
    func dateFormattersReusePool<T>(forKey key: CodingUserInfoKey?) throws -> T {
        guard let reusePool = self[key] else {
            throw CodingUserInfoError.valueNotFound(key)
        }

        guard let requestedReusePool = reusePool as? T else {
            throw CodingUserInfoError.typeMismatch(type(of: reusePool), T.self)
        }

        return requestedReusePool
    }

    func dateFormatter<Format: DateFormat>(for dateFormat: Format) throws -> DateFormatter {
        let reusePool = try dateFormattersReusePool(forKey: .dateFormattersReusePool) as DateFormattersReusePool
        return reusePool.dateFormatter(for: dateFormat)
    }

    func iso8601DateFormatter(for options: ISO8601DateFormatter.Options) throws -> ISO8601DateFormatter {
        let reusePool = try dateFormattersReusePool(forKey: .iso8601DateFormattersReusePool) as ISO8601DateFormattersReusePool
        return reusePool.dateFormatter(for: options)
    }
}
