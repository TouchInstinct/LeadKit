import UIKit

class ParalaxAnimator: CollapsibleViewsAnimator {
    var fractionComplete: CGFloat = 0
    var isWithAlphaAnimate = true
    
    init(isWithAlphaAnimate: Bool = true) {
        self.isWithAlphaAnimate = isWithAlphaAnimate
    }
    
    func setupView(container: CollapsibleViewsContainer) {
        guard let largeHeaderView = container.bottomHeaderView else {
            return
        }
        
        container.navBar?.topItem?.titleView?.alpha = 0
        
        let tableHeaderView = ParallaxTableHeaderView(subView: largeHeaderView)
        
        container.tableView.tableHeaderView = tableHeaderView
    }
    
    func animate(container: CollapsibleViewsContainer) {
        paralax(container: container)
        if isWithAlphaAnimate {
            container.navBar?.topItem?.titleView?.alpha = fractionComplete == 1 ? 1 : 0
        }
    }
    
    private func paralax(container: CollapsibleViewsContainer) {
        guard let header = container.tableView.tableHeaderView as? ParallaxTableHeaderView else {
            return
        }
        
        header.layoutForContentOffset(container.tableView.contentOffset)
    }
}
