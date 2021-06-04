import UIKit

public protocol NavigationBarСalculated {
    var navigationBar: UINavigationBar? { get }
    var window: UIWindow? { get }
}

extension NavigationBarСalculated {
    var navigationBarHeight: CGFloat {
        navigationBar?.bounds.height ?? 0
    }
    
    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    var navigationBarOffset: CGFloat {
        let prefersLargeTitles = navigationBar?.prefersLargeTitles ?? false
        return prefersLargeTitles
            ? navigationBarHeight - statusBarHeight
            : 0
    }
}
