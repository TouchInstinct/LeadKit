import Foundation
import AVFoundation

public extension UIInterfaceOrientation {

    var videoOrientation: AVCaptureVideoOrientation {
            switch self {
            case .portrait, .unknown:
                return .portrait

            case .landscapeLeft:
                return .landscapeLeft

            case .landscapeRight:
                return .landscapeRight

            case .portraitUpsideDown:
                return .portraitUpsideDown

            @unknown default:
                return .portrait
            }
        }
}
