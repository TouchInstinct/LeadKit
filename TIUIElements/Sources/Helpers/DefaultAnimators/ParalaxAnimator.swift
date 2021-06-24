import UIKit

final public class ParalaxAnimator: CollapsibleViewsAnimator {
    public var fractionComplete: CGFloat = 0
    var isWithAlphaAnimate = true
    
    init(isWithAlphaAnimate: Bool = true) {
        self.isWithAlphaAnimate = isWithAlphaAnimate
    }
    
    public func setupView(holder: CollapsibleViewsHolder, container: CollapsibleViewsContainer ) {
        guard let largeHeaderView = container.bottomHeaderView else {
            return
        }
        
        holder.navBar?.topItem?.titleView?.alpha = 0
        
        let tableHeaderView = ParallaxTableHeaderView(wrappedView: largeHeaderView)
        
        holder.tableView.tableHeaderView = tableHeaderView
    }
    
    public func animate(holder: CollapsibleViewsHolder) {
        paralax(holder: holder)
        if isWithAlphaAnimate {
            holder.navBar?.topItem?.titleView?.alpha = fractionComplete == 1 ? 1 : 0
        }
    }
    
    private func paralax(holder: CollapsibleViewsHolder) {
        guard let header = holder.tableView.tableHeaderView as? ParallaxTableHeaderView else {
            return
        }
        
        header.layout(for: holder.tableView.contentOffset)
    }
}
