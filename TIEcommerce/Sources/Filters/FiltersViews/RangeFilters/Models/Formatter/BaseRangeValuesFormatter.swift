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

open class BaseRangeValuesFormatter: RangeValuesFormatterProtocol {

    public let formatter: NumberFormatter

    public var floatValueDelimiter = "."

    public var formattingFailureValue = 0.0

    public init() {
        formatter = NumberFormatter()

        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
    }

    open func getIntervalInputLabel(state: BaseIntervalInputView.TextFieldState) -> String {
        switch state {
        case .fromValue:
            return "от"
        case .toValue:
            return "до"
        }
    }

    open func string(fromDouble value: Double) -> String {
        let nsNumber = NSNumber(floatLiteral: value)

        return formatter.string(from: nsNumber) ?? "\(formattingFailureValue)"
    }

    open func double(fromString value: String) -> Double {
        formatter.number(from: value)?.doubleValue ?? formattingFailureValue
    }
}
