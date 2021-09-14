import UIKit

public extension UIView {
    func transition(to coefficient: CGFloat) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.alpha = coefficient
            self?.transform = CGAffineTransform(translationX: 0, y: -coefficient*10)
        }
    }

    func scale(to coefficient: CGFloat) {
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.alpha = coefficient
            self?.transform = CGAffineTransform(scaleX: coefficient, y: coefficient)
        }
    }
}
