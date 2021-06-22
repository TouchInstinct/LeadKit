import UIKit

class TransitionAnimator: CollapsibleViewsAnimator {
    var fractionComplete: CGFloat = 0
    
    func setupView(container: CollapsibleViewsContainer) {
        container.navBar?.topItem?.titleView?.alpha = 0
    }
    
    func animate(container: CollapsibleViewsContainer) {
        container.navBar?.topItem?.titleView?.transition(to: fractionComplete)
    }
}
