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

    public var localizationProvider: AlertLocalizationProvider

    public init(localizationProvider: AlertLocalizationProvider = DefaultAlertLocalizationProvider()) {
        self.localizationProvider = localizationProvider
    }

    /// Provides general alert description.
    /// - Parameters:
    ///   - title: A text string used as the title of the alert.
    ///   - message: A text string used as the message of the alert.
    ///   - tint: A color used as a tint color of the alert. Default color is UIColor.systemBlue.
    ///   - actions: An array of actions of the alert.
    /// - Returns: Alert descriptor, which can be used to present alert view.
    open func alert(title: String? = nil,
                    message: String? = nil,
                    tint: UIColor = .systemBlue,
                    actions: [AlertAction]) -> AlertDescriptor {

        AlertDescriptor(title: title,
                        message: message,
                        tintColor: tint,
                        actions: actions)
    }

    /// Provides general sheet alert description.
    /// - Parameters:
    ///   - title: A text string used as the title of the sheet alert.
    ///   - message: A text string used as the message of the sheet alert.
    ///   - tint: A color used as a tint color of the sheet alert. Default color is UIColor.systemBlue.
    ///   - actions: An array of actions of the sheet alert.
    /// - Returns: Alert descriptor, which can be used to present sheet alert view.
    open func sheetAlert(title: String? = nil,
                         message: String? = nil,
                         tint: UIColor = .systemBlue,
                         actions: [AlertAction]) -> AlertDescriptor {

        AlertDescriptor(title: title,
                        message: message,
                        style: .actionSheet,
                        tintColor: tint,
                        actions: actions)
    }

    /// Provides ok type alert description.
    /// - Parameters:
    ///   - title: A text string used as the title of the alert.
    ///   - message: A text string used as the message of the alert.
    ///   - tint: A color used as a tint color of the alert. Default color is UIColor.systemBlue.
    /// - Returns: Alert descriptor, which can be used to present alert view.
    open func okAlert(title: String? = nil,
                      message: String? = nil,
                      tint: UIColor = .systemBlue) -> AlertDescriptor {

        AlertDescriptor(title: title,
                        message: message,
                        tintColor: tint,
                        actions: [.simpleAction(localizationProvider.okTitle)])
    }

    /// Provides retry type alert description.
    /// - Parameters:
    ///   - title: A text string used as the title of the alert.
    ///   - message: A text string used as the message of the alert.
    ///   - tint: A color used as a tint color of the alert. Default color is UIColor.systemBlue.
    ///   - retryAction: A closure called by tapping on the retry button of the alert.
    /// - Returns: Alert descriptor, which can be used to present alert view.
    open func retryAlert(title: String? = nil,
                         message: String? = nil,
                         tint: UIColor = .systemBlue,
                         retryAction: VoidClosure? = nil) -> AlertDescriptor {

        AlertDescriptor(title: title,
                        message: message,
                        tintColor: tint,
                        actions: [
                            .cancelAction(localizationProvider.cancelTitle),
                            .init(title: localizationProvider.retryTitle, action: retryAction)
                        ])
    }

    /// Provides dialogue type alert description. Dialogue type alert containes to buttons: Yes and No.
    /// - Parameters:
    ///   - title: A text string used as the title of the alert.
    ///   - message: A text string used as the message of the alert.
    ///   - tint: A color used as a tint color of the alert. Default color is UIColor.systemBlue.
    ///   - yesAction: A closure called by tapping on the yes button of the alert.
    ///   - noAction: A closure called by tapping on the no button of the alert.
    /// - Returns: Alert descriptor, which can be used to present alert view.
    open func dialogueAlert(title: String? = nil,
                            message: String? = nil,
                            tint: UIColor = .systemBlue,
                            yesAction: VoidClosure? = nil,
                            noAction: VoidClosure? = nil) -> AlertDescriptor {

        AlertDescriptor(title: title,
                        message: message,
                        tintColor: tint,
                        actions: [
                            .init(title: localizationProvider.yesTitle, action: yesAction),
                            .init(title: localizationProvider.noTitle, style: .destructive, action: noAction)
                        ])
    }
}

// MARK: - AlertAction + Helpers

private extension AlertAction {
    static func simpleAction(_ title: String,
                             style: UIAlertAction.Style = .default) -> AlertAction {

        AlertAction(title: title, style: style, action: nil)
    }

    static func cancelAction(_ title: String) -> AlertAction {
        .simpleAction(title, style: .cancel)
    }
}
