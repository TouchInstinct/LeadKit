import UIkit

public extension UIViewController {
    func presentFullScreen(_ viewController: UIViewController,
                           animated: Bool = true,
                           completion: (() -> Void)? = nil) {

        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}
