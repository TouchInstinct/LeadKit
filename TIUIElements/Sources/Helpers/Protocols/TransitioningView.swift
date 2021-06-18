import UIKit

public protocol TransitioningView: UIView {
    func transition(to fraction: CGFloat)
    func scale(alpha: CGFloat)
}

extension UIView: TransitioningView {
    public func transition(to alpha: CGFloat) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.alpha = alpha
            self?.transform = CGAffineTransform(translationX: 0, y: -alpha*10)
        }
    }
    
    public func scale(alpha: CGFloat) {
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.alpha = alpha
            self?.transform = CGAffineTransform(scaleX: alpha, y: alpha)
        }
    }
}
