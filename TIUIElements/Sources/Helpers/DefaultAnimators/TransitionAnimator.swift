import UIKit

final public class TransitionAnimator: CollapsibleViewsAnimator {
    public var fractionComplete: CGFloat = 0
    
    public func setupView(holder: CollapsibleViewsHolder, container: CollapsibleViewsContainer) {
        holder.navBar?.topItem?.titleView?.alpha = 0
    }
    
    public func animate(holder: CollapsibleViewsHolder) {
        holder.navBar?.topItem?.titleView?.transition(to: fractionComplete)
    }
}
