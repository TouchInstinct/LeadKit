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

public extension UIWindow {

    /// default scale
    static let snapshotScale: CGFloat = 1.5
    /// default root controller animation duration
    static let snapshotAnimationDuration = 0.5

    /**
     method changes root controller in window and sets status bar style

     - parameter controller:     new root controller
     - parameter statusBarStyle: new status bar style
     */
    public func changeRootController(controller: UIViewController,
                                     statusBarStyle: UIStatusBarStyle) {
        animateRootViewControllerChanging(controller: controller)

        rootViewController?.dismiss(animated: false, completion: nil)
        rootViewController = controller
        makeKeyAndVisible()
        UIApplication.shared.statusBarStyle = statusBarStyle
    }

    /**
     method animates changing root controller

     - parameter controller: new root controller
     */
    private func animateRootViewControllerChanging(controller: UIViewController) {
        if let snapshot = snapshotView(afterScreenUpdates: true) {
            controller.view.addSubview(snapshot)
            UIView.animate(withDuration: UIWindow.snapshotAnimationDuration, animations: {
                snapshot.layer.opacity = 0.0
                snapshot.layer.transform = CATransform3DMakeScale(UIWindow.snapshotScale,
                                                                  UIWindow.snapshotScale,
                                                                  UIWindow.snapshotScale)
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }

}
