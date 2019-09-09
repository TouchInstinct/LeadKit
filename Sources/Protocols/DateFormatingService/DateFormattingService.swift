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

/// Protocol that contains number formatting functions for often used number types.
public protocol DateFormattingService {

    associatedtype DateFormatType: DateFormat

    /// Region that will be used for parsing and formatting.
    var currentRegion: Region { get }

    /// Method parses date from string in given format with current region.
    /// If parsing fails - it returns default date in region.
    ///
    /// - Parameters:
    ///   - string: String to use for date parsing.
    ///   - format: Format that should be used for date parsing.
    ///   - defaultDate: Default date if formatting will fail.
    /// - Returns: Date parsed from given string or default date if parsing did fail.
    func date(from string: String, format: DateFormatType, defaultDate: DateInRegion) -> DateInRegion

    /// Method parses date from string in given format with passed region.
    ///
    /// - Parameters:
    ///   - string: String to use for date parsing.
    ///   - format: Format that should be used for date parsing.
    ///   - parsedIn: A region that should be used for date parsing. In case of nil defaultRegion will be used.
    /// - Returns: Date parsed from given string or default date if parsing did fail.
    func date(from string: String, format: DateFormatType, parsedIn: Region?) -> DateInRegion?

    /// Method parses date from string in one of the given formats with current region.
    ///
    /// - Parameters:
    ///   - string: String to use for date parsing.
    ///   - formats: Formats that should be used for date parsing.
    ///   - parsedIn: A region that should be used for date parsing. In case of nil defaultRegion will be used.
    /// - Returns: Date parsed from given string or default date if parsing did fail.
    func date(from string: String, formats: [DateFormatType], parsedIn: Region?) -> DateInRegion?

    /// Method format date in given format.
    ///
    /// - Parameters:
    ///   - date: Date to format.
    ///   - format: Format that should be used for date formatting.
    /// - Returns: String that contains formatted date or nil if formatting did fail.
    func string(from date: DateRepresentable, format: DateFormatType) -> String

    /// Method format date in given format for specific region.
    ///
    /// - Parameters:
    ///   - date: Date to format.
    ///   - format: Format that should be used for date formatting.
    ///   - formattedIn: A region that should be used for date formatting. In case of nil defaultRegion will be used.
    /// - Returns: String that contains formatted date or nil if formatting did fail.
    func string(from date: DateRepresentable, format: DateFormatType, formattedIn: Region?) -> String
}
