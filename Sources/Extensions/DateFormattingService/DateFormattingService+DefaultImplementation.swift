//
//  Copyright (c) 2018 Touch Instinct
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

import SwiftDate

public extension DateFormattingService {

    func date(from string: String,
              format: String,
              defaultDate: DateInRegion = Date().inDefaultRegion()) -> DateInRegion {

        return date(from: string, format: format) ?? defaultDate
    }

    func date(from string: String, format: String) -> DateInRegion? {
        return DateInRegion(string, format: format, region: currentRegion)
    }

    func string(from date: DateInRegion, format: DateFormatType) -> String {
        let dateInFormatterRegion = date.convertTo(region: currentRegion)

        return dateInFormatterRegion.toString(format.swiftDateFormat)
    }

}

public extension DateFormattingService where Self: Singleton {

    /// Method parses date from string in given format with current region.
    /// If parsing fails - it returns default date in region.
    ///
    /// - Parameters:
    ///   - string: String to use for date parsing.
    ///   - format: Format that should be used for date parsing.
    ///   - defaultDate: Default date if formatting will fail.
    /// - Returns: Date parsed from given string or default date if parsing did fail.
    static func date(from string: String,
                     format: String,
                     defaultDate: DateInRegion = Date().inDefaultRegion()) -> DateInRegion {

        return shared.date(from: string, format: format, defaultDate: defaultDate)
    }

    /// Method parses date from string in given format with current region.
    ///
    /// - Parameters:
    ///   - string: String to use for date parsing.
    ///   - format: Format that should be used for date parsing.
    /// - Returns: Date parsed from given string or default date if parsing did fail.
    static func date(from string: String, format: String) -> DateInRegion? {
        return shared.date(from: string, format: format)
    }

    /// Method format date in given format.
    ///
    /// - Parameters:
    ///   - date: Date to format.
    ///   - format: Format that should be used for date formatting.
    /// - Returns: String that contains formatted date or nil if formatting did fail.
    static func string(from date: DateInRegion, format: DateFormatType) -> String {
        return shared.string(from: date, format: format)
    }

}
