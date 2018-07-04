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

/// Separator configuration. Supports positioning, color and height per each separator
public struct SeparatorConfiguration {

    public let color: UIColor
    public let insets: UIEdgeInsets
    public let height: CGFloat

    /// Initialize configuration with parameters
    /// - parameter color: Color must be provided
    /// - parameter insets: Insets for separator. Default is no insets
    /// - parameter height: Height for separator. Default is 1 pixel
    /// - returns: Ready to use separator configuration
    public init(color: UIColor, insets: UIEdgeInsets = .zero, height: CGFloat = CGFloat(pixels: 1)) {
        self.color  = color
        self.insets = insets
        self.height = height
    }

}
