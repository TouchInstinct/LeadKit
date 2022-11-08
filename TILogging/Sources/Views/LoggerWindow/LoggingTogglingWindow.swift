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

import UIKit

@available(iOS 15, *)
final class LoggingTogglingWindow: UIWindow {

    override init(frame: CGRect) {
        super.init(frame: frame)

        windowLevel = .statusBar
        backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let rootView = rootViewController else { return false }

        if let loggingController = rootView.presentedViewController {
            return loggingController.view.point(inside: point, with: event)
        }

        if let button = rootView.view.subviews.first {
            let buttonPoint = convert(point, to: button)
            return button.point(inside: buttonPoint, with: event)
        }

        return false
    }
}

// MARK: - Registration for shaking event

public extension UIWindow {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if #available(iOS 15, *) {
            guard let window = getLoggingWindow() else {
                super.motionEnded(motion, with: event)
                return
            }

            checkForShakingMotion(motion, forWindow: window, with: event)

        } else {
            super.motionEnded(motion, with: event)
        }
    }

    @available(iOS 15, *)
    private func getLoggingWindow() -> LoggingTogglingWindow? {
        guard let windows = windowScene?.windows else {
            return nil
        }

        return windows.compactMap { $0 as? LoggingTogglingWindow }.first
    }

    @available(iOS 15, *)
    private func checkForShakingMotion(_ motion: UIEvent.EventSubtype,
                                       forWindow window: LoggingTogglingWindow,
                                       with event: UIEvent?) {
        guard let loggingController = window.rootViewController as? LoggingTogglingViewController else {
            super.motionEnded(motion, with: event)
            return
        }

        if motion == .motionShake, 
           logginController.isLogsPresented,
           loggingController.isRegisteredForShakingEvent {
            loggingController.openLoggingScreen()
        } else {
            super.motionEnded(motion, with: event)
        }
    }
}
