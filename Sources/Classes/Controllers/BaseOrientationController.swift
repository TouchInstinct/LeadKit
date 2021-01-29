import Foundation

open class BaseOrientationController: UIViewController {

    /// Ability to set forced screen orientation
    open var forcedInterfaceOrientation: UIInterfaceOrientation?

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            switch forcedInterfaceOrientation {
            case .landscapeLeft:
                return .landscapeLeft

            case .landscapeRight:
                return .landscapeRight

            case .portrait:
                return .portrait

            case .portraitUpsideDown:
                return .portraitUpsideDown

            default:
                return super.supportedInterfaceOrientations
            }
        }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        forcedInterfaceOrientation ?? super.preferredInterfaceOrientationForPresentation
    }
}
