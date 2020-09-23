import UIKit

public extension UIDevice {

    /// Вручную повернуть экран устройства
    ///
    /// - Parameters:
    ///   - orientation: ориентация в терминах ScreenOrientation
    func rotateOrientationManually(to orientation: UIInterfaceOrientation) {
        let orientationValue = Int(orientation.rawValue)
        UIDevice.current.setValue(orientationValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
}
