import UIKit

extension UIViewController: NavigationBarHandler {
    public var navBar: UINavigationBar? {
        navigationController?.navigationBar
    }
}
