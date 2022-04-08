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

open class DecodingErrorSummaryFormatter {
    public var codingPathSeparator = "."
    public var missingDataPlaceholder = "N/A"

    public init() {}

    open func format(summary: DecodingErrorSummary) -> String {
        """
        \(summary.errorDescription)

        json_value: \(summary.jsonValue)

        json_path: \(summary.codingPath)

        \(summary.requestMethod) \(summary.statusCode) \(summary.url)
        """
    }

    open func format(codingPath: [CodingKey]) -> String {
        let formattedPath = codingPath.reduce(into: "") {
            if let intValue = $1.intValue {
                $0.append("[\(intValue)]")
            } else {
                $0.append(codingPathSeparator)
                $0.append($1.stringValue)
            }
        }

        guard formattedPath.range(of: codingPathSeparator)?.lowerBound != formattedPath.startIndex else {
            return String(formattedPath.dropFirst())
        }

        return formattedPath
    }

    open func format(jsonValue: Any?) -> String {
        String(describing: jsonValue ?? missingDataPlaceholder)
    }
}
