import UIKit

open class OrientationNavigationController: UINavigationController {

    // MARK: - Public properties

    open var presentedOrTopViewController: UIViewController? {
        presentedViewController ?? topViewController
    }

    open override var shouldAutorotate: Bool {
        presentedOrTopViewController?.shouldAutorotate
            ?? super.shouldAutorotate
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        presentedOrTopViewController?.supportedInterfaceOrientations
            ?? super.supportedInterfaceOrientations
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        presentedOrTopViewController?.preferredInterfaceOrientationForPresentation
            ?? super.preferredInterfaceOrientationForPresentation
    }
}
