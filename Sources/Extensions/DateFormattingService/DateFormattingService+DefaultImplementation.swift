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
              format: DateFormatType,
              defaultDate: DateInRegion = Date().inDefaultRegion()) -> DateInRegion {

        return date(from: string, format: format, parsedIn: nil) ?? defaultDate
    }

    func date(from string: String,
              format: DateFormatType,
              parsedIn: Region?) -> DateInRegion? {

        let region = parsedIn ?? currentRegion

        return format.stringToDateFormat.toDate(string, region: region)
    }

    func date(from string: String, formats: [DateFormatType], parsedIn: Region?) -> DateInRegion? {
        let region = parsedIn ?? currentRegion

        for format in formats {
            if let parsedDate = format.stringToDateFormat.toDate(string, region: region) {
                return parsedDate
            }
        }

        return nil
    }

    func string(from date: DateRepresentable, format: DateFormatType) -> String {
        return format.dateToStringFormat.toString(date)
    }

    func string(from date: DateRepresentable, format: DateFormatType, formattedIn: Region?) -> String {
        let region = formattedIn ?? currentRegion

        let dateInFormatterRegion = date.convertTo(region: region)

        return format.dateToStringFormat.toString(dateInFormatterRegion)
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
                     format: DateFormatType,
                     defaultDate: DateInRegion = Date().inDefaultRegion()) -> DateInRegion {

        return shared.date(from: string, format: format, defaultDate: defaultDate)
    }

    /// Method parses date from string in given format with current region.
    ///
    /// - Parameters:
    ///   - string: String to use for date parsing.
    ///   - format: Format that should be used for date parsing.
    ///   - parsedIn: A region that should be used for date parsing. In case of nil defaultRegion will be used.
    /// - Returns: Date parsed from given string or default date if parsing did fail.
    static func date(from string: String, format: DateFormatType, parsedIn: Region?) -> DateInRegion? {
        return shared.date(from: string, format: format, parsedIn: parsedIn)
    }

    /// Method parses date from string in one of the given formats with current region.
    ///
    /// - Parameters:
    ///   - string: String to use for date parsing.
    ///   - formats: Formats that should be used for date parsing.
    ///   - parsedIn: A region that should be used for date parsing. In case of nil defaultRegion will be used.
    /// - Returns: Date parsed from given string or default date if parsing did fail.
    static func date(from string: String, formats: [DateFormatType], parsedIn: Region?) -> DateInRegion? {
        return shared.date(from: string, formats: formats, parsedIn: parsedIn)
    }

    /// Method format date in given format.
    ///
    /// - Parameters:
    ///   - date: Date to format.
    ///   - format: Format that should be used for date formatting.
    /// - Returns: String that contains formatted date or nil if formatting did fail.
    static func string(from date: DateRepresentable, format: DateFormatType) -> String {
        return shared.string(from: date, format: format)
    }

    /// Method format date in given format for specific region.
    ///
    /// - Parameters:
    ///   - date: Date to format.
    ///   - format: Format that should be used for date formatting.
    ///   - formattedIn: A region that should be used for date formatting. In case of nil defaultRegion will be used.
    /// - Returns: String that contains formatted date or nil if formatting did fail.
    static func string(from date: DateRepresentable, format: DateFormatType, formattedIn: Region?) -> String {
        return shared.string(from: date, format: format, formattedIn: formattedIn)
    }
}
