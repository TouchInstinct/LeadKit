//
//  Copyright (c) 2017 Touch Instinct
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

/// Structure describes "context" for date formatting.
public struct DateFormattingArguments: Hashable {

    let dateFormat: String
    let locale: Locale
    let timeZone: TimeZone

    /// Default initializer
    ///
    /// - Parameters:
    ///   - dateFormat: Date format to be used for formatting.
    ///   - locale: Locale to be used for formatting.
    ///   - timeZone: Time zone to be used for formatting.
    public init(dateFormat: String,
                locale: Locale = Locale.current,
                timeZone: TimeZone = TimeZone.current) {

        self.dateFormat = dateFormat
        self.locale = locale
        self.timeZone = timeZone
    }

    public var hashValue: Int {
        return dateFormat.hashValue ^ locale.hashValue ^ timeZone.hashValue
    }

    public static func == (lhs: DateFormattingArguments, rhs: DateFormattingArguments) -> Bool {
        return lhs.dateFormat == rhs.dateFormat &&
            lhs.locale.identifier == rhs.locale.identifier &&
            lhs.timeZone.identifier == rhs.timeZone.identifier
    }

}
