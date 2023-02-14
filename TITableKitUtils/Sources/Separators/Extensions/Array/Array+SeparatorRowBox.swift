//
//  Copyright (c) 2020 Touch Instinct
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

import TableKit
import TIUIElements

public extension Array where Element == SeparatorRowBox {

    /// Create rows from SeparatorRowBox array
    var rows: [Row] {
        return map { $0.row }
    }

    /// Configure separators from SeparatorRowBox array
    /// - parameter extreme: Appearance that will be used for extreme values, for first or last row
    /// - parameter middle: Apearance for intermediate rows
    func configureSeparators(extreme extremeSeparatorsAppearance: SeparatorAppearance,
                             middle middleSeparatorsAppearance: SeparatorAppearance) {

        configureSeparators(first: extremeSeparatorsAppearance,
                            middle: middleSeparatorsAppearance,
                            last: extremeSeparatorsAppearance)
    }

    /// Configure separators from SeparatorRowBox array
    /// - parameter first: Appearance of the top separator of the first row
    /// - parameter middle: Appearance of the separators between the rows
    /// - parameter last: Appearance of the bottom separator of the last row
    func configureSeparators(first firstSeparatorsAppearance: SeparatorAppearance,
                             middle middleSeparatorsAppearance: SeparatorAppearance,
                             last lastSeparatorsAppearance: SeparatorAppearance) {

        if isEmpty {
            return
        }

        switch count {
        case 1:
            first?.set(separatorType: .full(top: firstSeparatorsAppearance, bottom: lastSeparatorsAppearance))

        default:
            dropFirst().dropLast().forEach { $0.set(separatorType: .bottom(middleSeparatorsAppearance)) }
            first?.set(separatorType: .full(top: firstSeparatorsAppearance, bottom: middleSeparatorsAppearance))
            last?.set(separatorType: .bottom(lastSeparatorsAppearance))
        }
    }
}
