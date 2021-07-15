import UIKit

public extension UIViewController {

    var fixedTopOffet: CGFloat { // status bar + nav bar height calculate for UIViewController
        let navigationBar = navigationController?.navigationBar
        let window = view.window
        let prefersLargeTitles = navigationBar?.prefersLargeTitles ?? false

        let statusBarHeight: CGFloat
        if #available(iOS 13.0, *) {
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }

        let navigationBarHeight = navigationBar?.bounds.height ?? 0

        return prefersLargeTitles
            ? navigationBarHeight - statusBarHeight
            : 0
    }
}
