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

import UIKit

public extension CellSeparatorType {

    /// Determine if bottom separator is hidden.
    var bottomIsHidden: Bool {
        return bottomConfiguration == nil
    }

    /// Determine if top separator is hidden.
    var topIsHidden: Bool {
        return topConfiguration == nil
    }

    /// Returns top configuration if type is top or full.
    var topConfiguration: SeparatorConfiguration? {
        switch self {
        case .top(let configuration), .full(let configuration, _):
            return configuration
        default:
            return nil
        }
    }

    /// Returns bottom configuration if type is bottom or full.
    var bottomConfiguration: SeparatorConfiguration? {
        switch self {
        case .bottom(let configuration), .full(_, let configuration):
            return configuration
        default:
            return nil
        }
    }

    /// Configures top separator view with top configuration if type is top or full.
    ///
    /// - Parameter topSeparatorView: A top separator view to configure.
    func configure(topSeparatorView: UIView) {
        topSeparatorView.isHidden = topIsHidden
        topSeparatorView.backgroundColor = topConfiguration?.color ?? topSeparatorView.backgroundColor
    }

    /// Configures bottom separator view with top configuration if type is bottom or full.
    ///
    /// - Parameter bottomSeparatorView: A bottom separator view to configure.
    func configure(bottomSeparatorView: UIView) {
        bottomSeparatorView.isHidden = bottomIsHidden
        bottomSeparatorView.backgroundColor = bottomConfiguration?.color ?? bottomSeparatorView.backgroundColor
    }

    /// Configures both top and bottom separator views.
    ///
    /// - Parameters:
    ///   - topSeparatorView: A top separator view to configure.
    ///   - bottomSeparatorView: A bottom separator view to configure.
    func configure(topSeparatorView: UIView, bottomSeparatorView: UIView) {
        configure(topSeparatorView: topSeparatorView)
        configure(bottomSeparatorView: bottomSeparatorView)
    }

}
