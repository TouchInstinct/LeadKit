import UIKit.UIView

public extension UIView {

    /// Adds views to current view.
    ///
    /// - Parameter views: Views tha will be added to view.
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    /// Adds views to current view.
    ///
    /// - Parameter views: Views tha will be added to view.
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

}
