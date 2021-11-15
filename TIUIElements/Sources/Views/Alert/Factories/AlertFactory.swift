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

public enum AlertFactory {

    /// The main method of creating alerts
    public static func createAlert(with descriptor: AlertDescriptor) -> UIAlertController {
        let controller = UIAlertController(title: descriptor.title,
                                           message: descriptor.message,
                                           preferredStyle: descriptor.style)

        controller.view.tintColor = descriptor.tintColor

        for action in descriptor.actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.closure?()
            }
            controller.addAction(alertAction)
        }

        return controller
    }

    /// The auxiliary method of creating alerts
    public static func createAlert(title: String? = nil,
                                   message: String? = nil,
                                   actions: [UIAlertAction] = []) -> UIAlertController {

        let descriptor = AlertDescriptor(title: title, message: message, actions: actions)

        return createAlert(with: descriptor)
    }
}
