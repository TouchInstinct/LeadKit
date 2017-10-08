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

public struct SeparatorConfiguration {
    let color: UIColor
    let insets: UIEdgeInsets?
}

public enum CellSeparatorType {
    case none
    case top(SeparatorConfiguration)
    case bottom(SeparatorConfiguration)

    /// Top than bottom
    case full(SeparatorConfiguration, SeparatorConfiguration)

    var bottomIsHidden: Bool {
        switch self {
        case .top(_), .none:
            return true
        default:
            return false
        }
    }

    var topIsHidden: Bool {
        switch self {
        case .bottom(_), .none:
            return true
        default:
            return false
        }
    }

}

/// By default this class does not provide any searators
open class BaseCellViewModel {

    var separatorType = CellSeparatorType.none

    /// NOTE: Bottom dimension is ignored
    var topSeparatorConfiguration: SeparatorConfiguration?

    /// NOTE: Top dimension is ignored
    var bottomSeparatorConfiguration: SeparatorConfiguration?

    @discardableResult
    func with(separatorType: CellSeparatorType) -> Self {
        self.separatorType = separatorType

        switch separatorType {
        case .top(let configuration):
            topSeparatorConfiguration = configuration
        case .bottom(let configuration):
            bottomSeparatorConfiguration = configuration
        case .full(let top, let bottom):
            topSeparatorConfiguration = top
            bottomSeparatorConfiguration = bottom
        default:
            topSeparatorConfiguration = nil
            bottomSeparatorConfiguration = nil
        }

        return self
    }

}
