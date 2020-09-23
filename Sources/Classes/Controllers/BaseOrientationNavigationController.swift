import RxSwift
import UIKit

open class OrientationNavigationController: UINavigationController {

    // MARK: - Public properties

    open override var shouldAutorotate: Bool {
        return presentedViewController?.shouldAutorotate
            ?? topViewController?.shouldAutorotate
            ?? false
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return presentedViewController?.supportedInterfaceOrientations
            ?? topViewController?.supportedInterfaceOrientations
            ?? .portrait
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return presentedViewController?.preferredInterfaceOrientationForPresentation
            ?? topViewController?.preferredInterfaceOrientationForPresentation
            ?? .portrait
    }
}
