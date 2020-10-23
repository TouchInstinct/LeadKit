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

public enum ViewSeparatorType {

    /// All separators for view is hidden
    case none

    /// Show only top separator
    case top(SeparatorConfiguration)

    /// Show only bottom separator
    case bottom(SeparatorConfiguration)

    /// First configuration for top, second for bottom
    case full(SeparatorConfiguration, SeparatorConfiguration)
}

public extension ViewSeparatorType {

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
        case let .top(configuration), let .full(configuration, _):
            return configuration

        default:
            return nil
        }
    }

    /// Returns bottom configuration if type is bottom or full.
    var bottomConfiguration: SeparatorConfiguration? {
        switch self {
        case let .bottom(configuration), let .full(_, configuration):
            return configuration

        default:
            return nil
        }
    }
}
