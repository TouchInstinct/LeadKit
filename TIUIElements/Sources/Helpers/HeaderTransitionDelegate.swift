import Foundation
import UIKit

open class HeaderTransitionDelegate: NSObject, TransitioningHandler {
    public var animator: CollapsibleViewsAnimator?
    
    private weak var headerViewHandler: CollapsibleViewsContainer?
    
    private var startOffset: CGFloat = 0
    private var navigationBarOffset: CGFloat = 0
    private var isFirstScroll = true
    
    private var titleView: UIView? {
        get {
            headerViewHandler?.navBar?.topItem?.titleView
        }
        set {
            headerViewHandler?.navBar?.topItem?.titleView = newValue
        }
    }
    
    private var tableHeaderView: UIView? {
        get {
            headerViewHandler?.tableView.tableHeaderView
        }
        set {
            headerViewHandler?.tableView.tableHeaderView = newValue
        }
    }
    
    required public init(container: CollapsibleViewsContainer,
                         animator: CollapsibleViewsAnimator?) {
        self.headerViewHandler = container
        self.animator = animator
        super.init()
        
        initialUpdateHeaderView()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScrollHandler(scrollView)
    }
    
    open func scrollViewDidScrollHandler(_ scrollView: UIScrollView) {
        guard let largeHeaderView = headerViewHandler?.bottomHeaderView else {
            titleView?.isHidden = false
            return
        }
        
        if isFirstScroll {
            startOffset = max(-(headerViewHandler?.startOffset.y ?? 0), 0)
            navigationBarOffset = headerViewHandler?.fixedTopOffet ?? 0
            isFirstScroll = false
        }
        
        let offsetY = scrollView.contentOffset.y + startOffset
        
        var alpha = offsetY / (largeHeaderView.frame.height + navigationBarOffset)
        alpha = alpha > 1 ? 1 : alpha
        
        guard let headerViewHandler = headerViewHandler,
              var animator = animator else {
            titleView?.alpha = alpha == 1 ? 1 : 0
            return
        }
        
        animator.fractionComplete = alpha
        animator.animate(container: headerViewHandler)
    }
    
    private func setupView() {
        titleView?.alpha = animator == nil ? 0 : 1

        guard let headerViewHandler = headerViewHandler,
              let animator = animator else {
            return
        }

        animator.setupView(container: headerViewHandler)
    }
    
    private func initialUpdateHeaderView() {
        titleView = headerViewHandler?.topHeaderView

        setLargeHeader()

        setupView()
    }
    
    private func setLargeHeader() {
        guard let largeHeaderView = headerViewHandler?.bottomHeaderView else {
            return
        }
        
        tableHeaderView =  largeHeaderView
    }
}
