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
import UIKit

open class AlertFactory {

    open class func alert(title: String? = nil,
                          message: String? = nil,
                          tint: UIColor = .systemBlue,
                          actions: [AlertAction]) -> AlertDescriptor {

        return AlertDescriptor(title: title,
                               message: message,
                               style: .alert,
                               tintColor: tint,
                               actions: actions)
    }

    open class func sheetAlert(title: String? = nil,
                               message: String? = nil,
                               tint: UIColor = .systemBlue,
                               actions: [AlertAction]) -> AlertDescriptor {

        return AlertDescriptor(title: title,
                               message: message,
                               style: .actionSheet,
                               tintColor: tint,
                               actions: actions)
    }

    open class func okAlert(title: String? = nil,
                            message: String? = nil,
                            tint: UIColor = .systemBlue) -> AlertDescriptor {
        AlertDescriptor(title: title,
                        message: message,
                        style: .alert,
                        tintColor: tint,
                        actions: [.okAction])
    }

    open class func retryAlert(title: String? = nil,
                               message: String? = nil,
                               cancelTitle: String = "Cancel",
                               tint: UIColor = .systemBlue,
                               retryAction: VoidClosure? = nil) -> AlertDescriptor {
        AlertDescriptor(title: title,
                        message: message,
                        tintColor: tint,
                        actions: [.cancelAction(cancelTitle),
                                  AlertAction(title: "Retry", action: retryAction)])
    }
}

private extension AlertAction {
    static var okAction: AlertAction {
        AlertAction(title: "Ok", action: {})
    }

    static func cancelAction(_ title: String = "Cancel") -> AlertAction {
        AlertAction(title: title, style: .cancel, action: {})
    }
}
