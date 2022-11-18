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

import TIUIKitCore
import UIKit

@available(iOS 15, *)
public final class LoggingTogglingWindow: UIWindow {

    let loggingController = LoggingTogglingViewController()

    override public init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        rootViewController = loggingController
        windowLevel = .statusBar
        backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake,
           !loggingController.isLogsPresented {
            openLoggingScreen()

        } else {
            super.motionEnded(motion, with: event)
        }
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
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

    // MARK: - Public methdos

    public func set(isRegisteredForShakingEvent: Bool) {
        loggingController.set(isRegisteredForShakingEvent: isRegisteredForShakingEvent)
    }

    public func set(isVisible: Bool) {
        loggingController.set(isVisible: isVisible)
    }

    // MARK: - Private methods

    private func openLoggingScreen() {
        if loggingController.isRegisteredForShakingEvent {
            openLoggingScreenOnTopViewController()
        } else {
            loggingController.openLoggingScreen()
        }
    }

    private func openLoggingScreenOnTopViewController() {
        guard let rootViewController = rootViewController else {
            return
        }

        let topViewController = rootViewController.topVisibleViewController

        topViewController.present(LogsListViewController(), animated: true, completion: { [weak self] in
            self?.loggingController.set(isLogsPresented: false)
        })

        loggingController.set(isLogsPresented: true)
    }
}
