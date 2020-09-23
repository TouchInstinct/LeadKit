import RxSwift
import UIKit

open class OrientationNavigationController: UINavigationController {

    // MARK: - Public properties

    open override var shouldAutorotate: Bool {
        return presentedViewController?.shouldAutorotate
            ?? topViewController?.shouldAutorotate
            ?? super.shouldAutorotate
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return presentedViewController?.supportedInterfaceOrientations
            ?? topViewController?.supportedInterfaceOrientations
            ?? super.supportedInterfaceOrientations
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return presentedViewController?.preferredInterfaceOrientationForPresentation
            ?? topViewController?.preferredInterfaceOrientationForPresentation
            ?? super.preferredInterfaceOrientationForPresentation
    }
}
