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

/// A presenter of a window on which list of logs can be opened.
@available(iOS 15, *)
final public class LoggingPresenter {

    public static let shared = LoggingPresenter()

    private let loggingViewController = LoggingTogglingViewController()

    private lazy var window: LoggingTogglingWindow = {
        let window = LoggingTogglingWindow(frame: UIScreen.main.bounds,
                                           loggingController: loggingViewController)

        return window
    }()

    private init() { }

    /// Binds openning and closing of logging list view to a shaking motion.
    public func displayOnShakeEvent(of scene: UIWindowScene? = nil) {
        showWindow(withScene: scene)
        loggingViewController.set(isVisible: false)
        loggingViewController.set(isRegisteredForShakingEvent: true)
    }

    /// Shows the UIWindow with a button that opens a logging list view.
    public func addLogsButton(to scene: UIWindowScene? = nil, isShakingMotionAllowed isShaking: Bool = false) {
        showWindow(withScene: scene)
        loggingViewController.set(isVisible: true)
        loggingViewController.set(isRegisteredForShakingEvent: isShaking)
    }

    /// Shows the UIWindow
    public func showWindow(withScene scene: UIWindowScene? = nil) {
        if let scene = scene {
            window.windowScene = scene
        }

        window.makeKeyAndVisible()
    }

    /// Hides the UIWindow.
    public func hide() {
        window.isHidden = true
        loggingViewController.set(isVisible: true)
    }
}
