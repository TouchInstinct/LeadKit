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

import UIKit
import TISwiftUtils

public protocol AlertInformative {

    /// An alert informing about something with one closing button (by default ["OK"])
    func presentInfoAlert(title: String?)

    /// An alert informing about something with one closing button (by default ["OK"])
    func presentInfoAlert(title: String?,
                          message: String?)

    /// An alert informing about something with one closing button (by default ["OK"])
    func presentInfoAlert(title: String?,
                          message: String?,
                          infoStyle: UIAlertAction.Style)

    /// An alert informing about something with one closing button (by default ["OK"])
    func presentInfoAlert(title: String?,
                          infoAction: UIAlertAction?)

    /// An alert informing about something with one closing button (by default ["OK"])
    func presentInfoAlert(title: String?,
                          message: String?,
                          infoAction: UIAlertAction?)

    /// An alert informing about something with one closing button (by default ["OK"])
    func presentInfoAlert(title: String?,
                          message: String?,
                          infoTitle: String?,
                          infoStyle: UIAlertAction.Style,
                          infoAction: UIAlertAction?)

    /// Alert offering to repeat the action (with the "Repeat" and "Cancel" buttons)
    func presentRetryAlert(title: String?,
                           message: String?,
                           retryAction: @escaping UIAlertAction)

    /// Alert offering to repeat the action (with the "Repeat" and "Cancel" buttons)
    func presentRetryAlert(title: String?,
                           message: String?,
                           retryAction: @escaping UIAlertAction,
                           cancelAction: UIAlertAction?)

    /// Alert with custom actions and cancel button
    func presentActionsAlert(title: String?,
                             message: String?,
                             actions: [UIAlertAction],
                             cancelAction: UIAlertAction?)
}
