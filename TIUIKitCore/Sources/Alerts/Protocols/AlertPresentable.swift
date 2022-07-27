//
//  Copyright (c) 2022 Touch Instinct
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

/// A protocol represents an alert which can be presented on the given context.
///
/// ```import PopupDialog
///
/// extension PopupDialog: AlertPresentable {
///     @discardableResult
///     public func configured(with configuration: AlertDescriptor) -> Self {
///         title = configuration.title
///
///         for action in configuration.actions {
///             addButton(DefaultButton(title: action.title, action: action.action))
///         }
///
///         return self
///     }
///
///     public func present(on context: AlertPresentationContext, completion: VoidClosure?) {
///         context.present(self, animated: true, completion: completion)
///     }
/// }
/// ```
///
/// The implementation of this protocol says that an alert can be shown from the context. By default, the standard `UIAlertController` conforms to the protocol. Accordingly, when using a custom alert, it must also conform to the protocol.
public protocol AlertPresentable {
    func present(on context: AlertPresentationContext, completion: VoidClosure?)
}
