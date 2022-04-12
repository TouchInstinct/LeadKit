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

// Creating a date formatter is not a cheap operation.
// If you are likely to use a formatter frequently,
// it is typically more efficient to cache a single instance
// than to create and dispose of multiple instances.
// (https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW10)
open class DateFormattersReusePool {
    private var pool: [String: DateFormatter] = [:]

    private let presetLocale: Locale?
    private let presetTimeZone: TimeZone?

    public init(presetLocale: Locale? = nil, presetTimeZone: TimeZone? = nil) {
        self.presetLocale = presetLocale
        self.presetTimeZone = presetTimeZone
    }

    open func dateFormatter<Format: DateFormat>(for dateFormat: Format) -> DateFormatter {
        guard let cachedFormatter = pool[dateFormat.rawValue] else {
            return register(dateFormat: dateFormat)
        }

        return cachedFormatter
    }

    open func register<Format: DateFormat>(format: Format.Type) {
        for dateFormat in Format.allCases {
            register(dateFormat: dateFormat)
        }
    }

    @discardableResult
    open func register<Format: DateFormat>(dateFormat: Format) -> DateFormatter {
        let dateFormatter = DateFormatter(dateFormat: dateFormat)

        if let locale = presetLocale {
            dateFormatter.locale = locale
        }

        if let timeZone = presetTimeZone {
            dateFormatter.timeZone = timeZone
        }

        pool[dateFormat.rawValue] = dateFormatter

        return dateFormatter
    }
}
