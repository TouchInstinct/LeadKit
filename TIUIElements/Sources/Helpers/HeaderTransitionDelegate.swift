import Foundation
import UIKit

open class HeaderTransitionDelegate: NSObject, UIScrollViewDelegate {
    
    public enum HeaderAnimationType {
        case onlyParalax, paralaxWithTransition, transition, scale, paralaxWithScale, none
    }
    
    private weak var headerViewHandler: CollapsibleViewsContainer?
    private let headerAnimationType: HeaderAnimationType
    
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
    
    public init(headerViewHandler: CollapsibleViewsContainer,
                headerAnimationType: HeaderAnimationType = .none) {
        self.headerViewHandler = headerViewHandler
        self.headerAnimationType = headerAnimationType
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
        
        animate(headerAnimation: headerAnimationType, alpha: alpha)
    }
    
    private func setupView() {
        switch headerAnimationType {
        case .scale, .paralaxWithScale:
            titleView?.transform = CGAffineTransform(scaleX: -0.5, y: 0.5)
            
        case .paralaxWithTransition, .transition:
            break
            
        default:
            titleView?.alpha = 1
            titleView?.isHidden = true
        }
    }
    
    private func initialUpdateHeaderView() {
        titleView = headerViewHandler?.topHeaderView
        titleView?.alpha = 0

        setLargeHeader()
        
        setupView()
    }
    
    private func setLargeHeader() {
        guard let largeHeaderView = headerViewHandler?.bottomHeaderView else {
            return
        }
        
        switch headerAnimationType {
        case .paralaxWithScale, .paralaxWithTransition, .onlyParalax:
            tableHeaderView =  ParallaxTableHeaderView(subView: largeHeaderView)
            
        default:
            tableHeaderView =  largeHeaderView
        }
    }
    
    private func animate(headerAnimation: HeaderAnimationType, alpha: CGFloat) {
        switch headerAnimation {
        case .paralaxWithTransition:
            titleView?.transition(to: alpha)
            paralax()
            
        case .transition:
            titleView?.transition(to: alpha)
            
        case .onlyParalax:
            paralax()
            titleView?.isHidden = alpha != 1
            
        case .scale:
            titleView?.scale(alpha: alpha)
            
        case .paralaxWithScale:
            titleView?.scale(alpha: alpha)
            paralax()
            
        default:
            titleView?.isHidden = alpha != 1
        }
    }
    
    private func paralax() {
        guard let tableView = headerViewHandler?.tableView,
              let header = tableView.tableHeaderView as? ParallaxTableHeaderView else {
            return
        }
        
        header.layoutForContentOffset(tableView.contentOffset)
    }
}
