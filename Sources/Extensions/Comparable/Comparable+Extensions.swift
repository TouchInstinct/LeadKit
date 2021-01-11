//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public extension Comparable {

    /// Use this function to restrict comparable with lower and upper values
    /// - parameter bounds: Lower and uppper bounds tuple
    /// - returns: Current value if it fits range, otherwise lower if value is too small or upper if value is too big
    func `in`(bounds: (lower: Self, upper: Self)) -> Self {
        min(max(bounds.lower, self), bounds.upper)
    }

    /// Use this function to restrict comparable with lower and upper values
    /// - parameter range: ClosedRange representing bounds
    /// - returns: Current value if it fits range, otherwise lower if value is too small or upper if value is too big
    func `in`(range: ClosedRange<Self>) -> Self {
        `in`(bounds: (lower: range.lowerBound, upper: range.upperBound))
    }
}
