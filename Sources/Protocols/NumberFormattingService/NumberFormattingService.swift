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

import Foundation

/// Protocol that contains number formatting functions for often used number types.
public protocol NumberFormattingService {

    associatedtype NumberFormatType: NumberFormat

    var formatters: [NumberFormatType: NumberFormatter] { get }

    /// Returns NumberFormatter for given NumberFormatType.
    ///
    /// - Parameter format: A number format under which should be configured NumberFormatter.
    /// - Returns: Configured NumberFormatter instance.
    func numberFormatter(for format: NumberFormatType) -> NumberFormatter

    /// Format number in given format. If formatting fails - it returns default string.
    ///
    /// - Parameters:
    ///   - number: A number to format.
    ///   - format: A format that should be used for number formatting.
    ///   - defaultString: Default string if formatting will fail.
    /// - Returns: An string that contains formatted number or default string if formatting did fail.
    func string(from number: NSNumberConvertible, format: NumberFormatType, defaultString: String) -> String

    /// Parses number from string in given format.
    ///
    /// - Parameters:
    ///   - string: A string to parse.
    ///   - format: A format that should be used for number parsing.
    /// - Returns: Parsed number or nil if parsing will fail.
    func number(from string: String, format: NumberFormatType) -> NSNumber?

}
