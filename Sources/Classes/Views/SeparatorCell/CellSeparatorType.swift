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

import UIKit

/// Cell self-descriptive separator type
public enum CellSeparatorType {

    /// All separators for cell hidden
    case none

    /// Show only top separator
    case top(SeparatorConfiguration)

    /// Show only bottom separator
    case bottom(SeparatorConfiguration)

    /// First configuration for top, second for bottom
    case full(SeparatorConfiguration, SeparatorConfiguration)
}

public extension CellSeparatorType {

    /// Determine if bottom separator is hidden
    var bottomIsHidden: Bool {
        switch self {
        case .top, .none:
            return true
        case .bottom, .full:
            return false
        }
    }

    /// Determine if top separator is hidden
    var topIsHidden: Bool {
        switch self {
        case .bottom, .none:
            return true
        case .top, .full:
            return false
        }
    }

}
