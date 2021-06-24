import UIKit

final public class ScaleAnimator: CollapsibleViewsAnimator {
    public var fractionComplete: CGFloat = 0
    
    public func setupView(holder: CollapsibleViewsHolder, container: CollapsibleViewsContainer) {
        holder.navBar?.topItem?.titleView?.alpha = 0
        holder.navBar?.topItem?.titleView?.transform = CGAffineTransform(scaleX: -0.5, y: 0.5)
    }
    
    public func animate(holder: CollapsibleViewsHolder) {
        holder.navBar?.topItem?.titleView?.scale(to: fractionComplete)
    }
}
