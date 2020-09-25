import UIKit

open class OrientationNavigationController: UINavigationController {

    // MARK: - Public properties

    open override var shouldAutorotate: Bool {
        presentedViewController?.shouldAutorotate
            ?? topViewController?.shouldAutorotate
            ?? super.shouldAutorotate
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        presentedViewController?.supportedInterfaceOrientations
            ?? topViewController?.supportedInterfaceOrientations
            ?? super.supportedInterfaceOrientations
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        presentedViewController?.preferredInterfaceOrientationForPresentation
            ?? topViewController?.preferredInterfaceOrientationForPresentation
            ?? super.preferredInterfaceOrientationForPresentation
    }
}
