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

    private lazy var window: LoggingTogglingWindow = {
        let window = LoggingTogglingWindow(frame: UIScreen.main.bounds)
        window.rootViewController = loggingViewController

        return window
    }()

    private lazy var loggingViewController: LoggingTogglingViewController = {
        LoggingTogglingViewController()
    }()

    private init() { }

    /// binds openning and closing of logging list view to a shaking motion.
    public func bind(_ scene: UIWindowScene? = nil) {
        if let scene = scene {
            window.windowScene = scene
        }

        window.makeKeyAndVisible()
        loggingViewController.setVisible(isVisible: false)
    }

    /// unbinds openning and closing of logging list view by shaking motion.
    public func unbind() {
        window.isHidden = true
        loggingViewController.setVisible(isVisible: true)
    }

    /// shows the UIWindow with a button that opens a logging list view.
    public func start(_ scene: UIWindowScene? = nil) {
        if let scene = scene {
            window.windowScene = scene
        }

        window.isHidden = false
    }

    /// hides the UIWindow.
    public func stop() {
        window.isHidden = true
    }
}
