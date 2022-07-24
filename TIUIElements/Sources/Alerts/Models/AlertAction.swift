//
//  Copyright (c) 2021 Touch Instinct
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

import TISwiftUtils
import UIKit

// struct describe alert button information
public struct AlertAction: Identifiable {

    public let id = UUID()

    /// Alert button title
    public let title: String

    /// Alert button style
    public let style: UIAlertAction.Style

    /// Alert button action
    public let action: VoidClosure?

    init(title: String, style: UIAlertAction.Style = .default, action: VoidClosure? = nil) {
        self.title = title
        self.style = style
        self.action = action
    }
}

// MARK: - AlertAction + Equatable

extension AlertAction: Equatable {
    public static func == (lhs: AlertAction, rhs: AlertAction) -> Bool {
        return false
    }
}

// MARK: - AlertAction + Helpers

extension AlertAction {
    var asUIAlertAction: UIAlertAction {
        UIAlertAction(title: title, style: style, handler: { _ in action?() })
    }
}
