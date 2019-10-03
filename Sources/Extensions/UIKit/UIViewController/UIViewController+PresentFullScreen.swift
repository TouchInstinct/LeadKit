import UIkit

public extension UIViewController {
    /// Method present new ViewController modally in full screen mode
    ///
    /// - Parameters:
    ///   - viewController: ViewController to present
    ///   - animated: ppresent with animation
    ///   - completion: completion block after present ended
    func presentFullScreen(_ viewController: UIViewController,
                           animated: Bool = true,
                           completion: (() -> Void)? = nil) {

        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}
