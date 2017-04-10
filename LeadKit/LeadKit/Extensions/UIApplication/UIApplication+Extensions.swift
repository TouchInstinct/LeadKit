//
//  Copyright (c) 2017 Touch Instinct
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

public extension UIApplication {

    /// default scale
    static let snapshotScale: CGFloat = 1.5
    /// default root controller animation duration
    static let snapshotAnimationDuration = 0.5

    /**
     static method changes root controller in window and sets status bar style
     
     - parameter controller:     new root controller
     - parameter statusBarStyle: new status bar style
     - parameter appWindow:      application window
    */
    public static func changeRootController(controller: UIViewController,
                                            statusBarStyle: UIStatusBarStyle,
                                            appWindow: UIWindow?) {
        guard let window = appWindow else {
            return
        }

        animateRootViewControllerChanging(controller: controller, window: window)

        window.rootViewController?.dismiss(animated: false, completion: nil)
        window.rootViewController = controller
        window.makeKeyAndVisible()
        UIApplication.shared.statusBarStyle = statusBarStyle
    }

    /**
     static method animates changing root controller
     
     - parameter controller: new root controller
     - parameter window:     current window
    */
    private static func animateRootViewControllerChanging(controller: UIViewController,
                                                          window: UIWindow) {
        if let snapshot = window.snapshotView(afterScreenUpdates: true) {
            controller.view.addSubview(snapshot)
            UIView.animate(withDuration: snapshotAnimationDuration, animations: {
                snapshot.layer.opacity = 0.0
                snapshot.layer.transform = CATransform3DMakeScale(snapshotScale,
                                                                  snapshotScale,
                                                                  snapshotScale)
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }

}
