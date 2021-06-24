import Foundation
import UIKit

final public class TableViewHeaderTransitioningHandler: NSObject, TransitioningHandler {
    public var animator: CollapsibleViewsAnimator?
    
    private var collapsibleViewsContainer: CollapsibleViewsContainer?
    private var collapsibleViewsHolder: CollapsibleViewsHolder?
    
    private var startOffset: CGFloat = 0
    private var navigationBarOffset: CGFloat = 0
    private var isFirstScroll = true
    
    private var titleView: UIView? {
        get {
            collapsibleViewsHolder?.navBar?.topItem?.titleView
        }
        set {
            collapsibleViewsHolder?.navBar?.topItem?.titleView = newValue
        }
    }
    
    private var tableHeaderView: UIView? {
        get {
            collapsibleViewsHolder?.tableView.tableHeaderView
        }
        set {
            collapsibleViewsHolder?.tableView.tableHeaderView = newValue
        }
    }
    
    public init(collapsibleViewsContainer: CollapsibleViewsContainer?,
                collapsibleViewsHolder: CollapsibleViewsHolder?,
                animator: CollapsibleViewsAnimator?) {
        self.collapsibleViewsContainer = collapsibleViewsContainer
        self.collapsibleViewsHolder = collapsibleViewsHolder
        self.animator = animator
        super.init()
        
        initialUpdateHeaderView()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let largeHeaderView = collapsibleViewsContainer?.bottomHeaderView else {
            titleView?.isHidden = false
            return
        }
        
        if isFirstScroll {
            startOffset = max(-(collapsibleViewsHolder?.startOffset.y ?? 0), 0)
            navigationBarOffset = collapsibleViewsContainer?.fixedTopOffet ?? 0
            isFirstScroll = false
        }
        
        let offsetY = scrollView.contentOffset.y + startOffset
        
        var alpha = offsetY / (largeHeaderView.frame.height + navigationBarOffset)
        alpha = alpha > 1 ? 1 : alpha
        
        guard let collapsibleViewsHolder = collapsibleViewsHolder,
              var animator = animator else {
            titleView?.alpha = alpha == 1 ? 1 : 0
            return
        }
        
        animator.fractionComplete = alpha
        animator.animate(holder: collapsibleViewsHolder)
    }
    
    private func setupView() {
        titleView?.alpha = animator == nil ? 0 : 1

        guard let collapsibleViewsHolder = collapsibleViewsHolder,
              let collapsibleViewsContainer = collapsibleViewsContainer,
              let animator = animator else {
            return
        }

        animator.setupView(holder: collapsibleViewsHolder, container: collapsibleViewsContainer)
    }
    
    private func initialUpdateHeaderView() {
        titleView = collapsibleViewsContainer?.topHeaderView

        setLargeHeader()

        setupView()
    }
    
    private func setLargeHeader() {
        guard let largeHeaderView = collapsibleViewsContainer?.bottomHeaderView else {
            return
        }
        
        tableHeaderView =  largeHeaderView
    }
}
