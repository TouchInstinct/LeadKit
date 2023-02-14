//
//  Copyright (c) 2023 Touch Instinct
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

public extension UIEdgeInsets {

    // MARK: - Factory methods

    static func edges(_ insets: CGFloat) -> UIEdgeInsets {
        .init(top: insets, left: insets, bottom: insets, right: insets)
    }

    static func horizontal(_ insets: CGFloat) -> UIEdgeInsets {
        .init(top: .zero, left: insets, bottom: .zero, right: insets)
    }

    static func vertical(_ insets: CGFloat) -> UIEdgeInsets {
        .init(top: insets, left: .zero, bottom: insets, right: .zero)
    }

    static func horizontal(left: CGFloat = .zero, right: CGFloat = .zero) -> UIEdgeInsets {
        .init(top: .zero, left: left, bottom: .zero, right: right)
    }

    static func vertical(top: CGFloat = .zero, bottom: CGFloat = .zero) -> UIEdgeInsets {
        .init(top: top, left: .zero, bottom: bottom, right: .zero)
    }

    // MARK: - Instance methods

    func horizontal(_ insets: CGFloat) -> UIEdgeInsets {
        .init(top: top, left: insets, bottom: bottom, right: insets)
    }

    func vertical(_ insets: CGFloat) -> UIEdgeInsets {
        .init(top: insets, left: left, bottom: insets, right: right)
    }

    func horizontal(left: CGFloat = .zero, right: CGFloat = .zero) -> UIEdgeInsets {
        .init(top: top, left: left, bottom: bottom, right: right)
    }

    func vertical(top: CGFloat = .zero, bottom: CGFloat = .zero) -> UIEdgeInsets {
        .init(top: top, left: left, bottom: bottom, right: right)
    }
}
