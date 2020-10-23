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

import UIKit.UIFont
import UIKit.UIColor

/// Base set of attributes to configure appearance of text.
open class BaseTextAttributes {

    /// Text font.
    public let font: UIFont
    /// Text color.
    public let color: UIColor
    /// Text alignment.
    public let alignment: NSTextAlignment

    /// Memberwise initializer.
    ///
    /// - Parameters:
    ///   - font: Text font.
    ///   - color: Text color.
    ///   - alignment: Text alignment.
    public init(font: UIFont, color: UIColor, alignment: NSTextAlignment = .natural) {
        self.font = font
        self.color = color
        self.alignment = alignment
    }
}

public extension BaseTextAttributes {

    /// Configures text appearance of given ViewTextConfigurable instance.
    ///
    /// - Parameter view: ViewTextConfigurable instance to configure with BaseTextAttributes.
    func configureBaseApperance(of view: ViewTextConfigurable) {
        view.configureBaseAppearance(with: self)
    }
}
