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

/// Date formatting service. Used for date to string and string to date formatting.
/// Takes into account locale and timezone.
open class DateFormattingService {

    private var dateFormatters: [DateFormattingArguments: DateFormatter] = [:]

    public init(formattingArguments: [DateFormattingArguments] = []) {
        for argument in formattingArguments {
            register(arguments: argument)
        }
    }

    /// DateFormatter registration method.
    ///
    /// - Parameter arguments: A formatting arguments structure.
    public func register(arguments: DateFormattingArguments) {
        dateFormatters[arguments] = arguments.dateFormatter
    }

    /// String to date convertion method.
    ///
    /// - Parameters:
    ///   - dateString: The string to parse.
    ///   - arguments: A formatting arguments structure.
    /// - Returns: A date representation of a given string interpreted using given arguments.
    public func date(from dateString: String, arguments: DateFormattingArguments) -> Date? {
        guard let dateFormatter = dateFormatters[arguments] else {
            fatalError("No date formatter registered for given arguments: \(arguments)")
        }

        return dateFormatter.date(from: dateString)
    }

    /// Date to string convertion method.
    ///
    /// - Parameters:
    ///   - date: The date to format.
    ///   - arguments: A formatting arguments structure.
    /// - Returns: A string representation of a given date formatted using given arguments.
    public func string(from date: Date, arguments: DateFormattingArguments) -> String? {
        guard let dateFormatter = dateFormatters[arguments] else {
            fatalError("No date formatter registered for given arguments: \(arguments)")
        }

        return dateFormatter.string(from: date)
    }
    
}
