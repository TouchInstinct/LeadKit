import UIkit

public extension UIViewController {

    /// Method present new ViewController modally in full screen mode by default
    ///
    /// - Parameters:
    ///   - viewController: ViewController to present
    ///   - presentationStyle: presentation style (default is `fullScreen`
    ///   - animated: present with animation or not
    ///   - completion: completion block after present finish
    func presentModal(_ viewController: UIViewController,
                      presentationStyle: UIModalPresentationStyle = .fullScreen,
                      animated: Bool = true,
                      completion: (() -> Void)? = nil) {

        viewController.modalPresentationStyle = presentationStyle
        present(viewController, animated: animated, completion: completion)
    }
}
