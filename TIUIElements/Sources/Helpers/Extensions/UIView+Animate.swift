import UIKit

extension UIView {
    public func transition(to coefficient: CGFloat) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.alpha = coefficient
            self?.transform = CGAffineTransform(translationX: 0, y: -coefficient*10)
        }
    }

    public func scale(to coefficient: CGFloat) {
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.alpha = coefficient
            self?.transform = CGAffineTransform(scaleX: coefficient, y: coefficient)
        }
    }
}
