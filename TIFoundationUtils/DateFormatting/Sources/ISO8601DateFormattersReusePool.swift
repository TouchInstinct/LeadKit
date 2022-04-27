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

open class ISO8601DateFormattersReusePool {
    private var pool: ThreadSafeDictionary<ISO8601DateFormatter.Options, ISO8601DateFormatter> = [:]

    private let presetTimeZone: TimeZone?

    public init(presetTimeZone: TimeZone? = nil) {
        self.presetTimeZone = presetTimeZone
    }

    open func dateFormatter(for options: ISO8601DateFormatter.Options) -> ISO8601DateFormatter {
        guard let cachedFormatter = pool[options] else {
            return register(options: options)
        }

        return cachedFormatter
    }

    @discardableResult
    open func register(options: ISO8601DateFormatter.Options) -> ISO8601DateFormatter {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = options

        if let timeZone = presetTimeZone {
            dateFormatter.timeZone = timeZone
        }

        pool[options] = dateFormatter

        return dateFormatter
    }
}

// Conformance of 'ISO8601DateFormatter.Options' to 'Hashable' is only available in iOS 15.0 or newer
extension ISO8601DateFormatter.Options: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
