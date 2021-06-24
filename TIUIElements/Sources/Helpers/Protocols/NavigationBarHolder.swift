import UIKit

public protocol NavigationBarHolder {
    var navBar: UINavigationBar? { get }
}

extension UIViewController: NavigationBarHolder {
    public var navBar: UINavigationBar? {
        navigationController?.navigationBar
    }
}
