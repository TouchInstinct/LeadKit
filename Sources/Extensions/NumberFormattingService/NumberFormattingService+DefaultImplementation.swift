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

public extension NumberFormattingService {

    /// Computed static property. Use only once for `formatters` field implementation!
    static var computedFormatters: [NumberFormatType: NumberFormatter] {
        return Dictionary(uniqueKeysWithValues: NumberFormatType.allOptions.map { ($0, $0.numberFormatter) })
    }

    static func numberFormatter(for format: NumberFormatType) -> NumberFormatter {
        guard let formatter = formatters[format] else {
            fatalError("Unregistered number formatter for \(format)")
        }

        return formatter
    }

    static func string(from number: NSNumber, format: NumberFormatType, defaultString: String = "") -> String {
        return numberFormatter(for: format).string(from: number) ?? defaultString
    }

    static func string(from number: Decimal, format: NumberFormatType, defaultString: String = "") -> String {
        return string(from: NSDecimalNumber(decimal: number), format: format, defaultString: defaultString)
    }

    static func string(from number: Int, format: NumberFormatType, defaultString: String = "") -> String {
        return string(from: NSNumber(value: number), format: format, defaultString: defaultString)
    }

    static func string(from number: Int64, format: NumberFormatType, defaultString: String = "") -> String {
        return string(from: NSNumber(value: number), format: format, defaultString: defaultString)
    }

    static func string(from number: Float, format: NumberFormatType, defaultString: String = "") -> String {
        return string(from: NSNumber(value: Double(number)), format: format, defaultString: defaultString)
    }

    static func string(from number: Double, format: NumberFormatType, defaultString: String = "") -> String {
        return string(from: NSNumber(value: number), format: format, defaultString: defaultString)
    }

}
