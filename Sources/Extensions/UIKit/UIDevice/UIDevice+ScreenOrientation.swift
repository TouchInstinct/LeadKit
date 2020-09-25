import UIKit

public extension UIDevice {

    /// Вручную повернуть экран устройства
    ///
    /// - Parameters:
    ///   - orientation: ориентация в терминах ScreenOrientation
    func rotateManually(to orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(orientation, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
}
