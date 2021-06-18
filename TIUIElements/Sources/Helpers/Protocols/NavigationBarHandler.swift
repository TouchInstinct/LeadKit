import UIKit

public protocol NavigationBarHandler {
    var navBar: UINavigationBar? { get }
}

extension UIViewController: NavigationBarHandler {
    public var navBar: UINavigationBar? {
        navigationController?.navigationBar
    }
}
