import UIKit

class ScaleAnimator: CollapsibleViewsAnimator {
    var fractionComplete: CGFloat = 0
    
    func setupView(container: CollapsibleViewsContainer) {
        container.navBar?.topItem?.titleView?.alpha = 0
        container.navBar?.topItem?.titleView?.transform = CGAffineTransform(scaleX: -0.5, y: 0.5)
    }
    
    func animate(container: CollapsibleViewsContainer) {
        container.navBar?.topItem?.titleView?.scale(alpha: fractionComplete)
    }
}
