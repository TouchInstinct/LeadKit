import Foundation
import UIKit

open class HeaderTransitionDelegate: NSObject, UIScrollViewDelegate {
    
    public enum HeaderAnimationType {
        case onlyParalax, paralaxWithTransition, transition, scale, paralaxWithScale, none
    }
    
    private weak var headerViewHandler: HeaderViewHandlerProtocol?
    private let headerAnimationType: HeaderAnimationType
    
    private var startOffset: CGFloat = 0
    private var navigationBarOffset: CGFloat = 0
    private var isFirstScroll = true
    
    private var titleView: UIView? {
        get {
            headerViewHandler?.navigationBar?.topItem?.titleView
        }
        set {
            headerViewHandler?.navigationBar?.topItem?.titleView = newValue
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
    
    public init(headerViewHandler: HeaderViewHandlerProtocol,
                headerAnimationType: HeaderAnimationType = .paralaxWithTransition) {
        self.headerViewHandler = headerViewHandler
        self.headerAnimationType = headerAnimationType
        super.init()
        
        initialUpdateHeaderView()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScrollHandler(scrollView)
    }
    
    open func scrollViewDidScrollHandler(_ scrollView: UIScrollView) {
        guard let largeHeaderView = headerViewHandler?.largeHeaderView else {
            titleView?.isHidden = false
            return
        }
        
        if isFirstScroll {
            startOffset = max(-(headerViewHandler?.startOffset.y ?? 0), 0)
            navigationBarOffset = headerViewHandler?.navigationBarOffset ?? 0
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
        titleView = headerViewHandler?.headerView
        titleView?.alpha = 0

        setLargeHeader()
        
        setupView()
    }
    
    private func setLargeHeader() {
        guard let largeHeaderView = headerViewHandler?.largeHeaderView else {
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
            transition(alpha: alpha)
            paralax()
            
        case .transition:
            transition(alpha: alpha)
            
        case .onlyParalax:
            paralax()
            titleView?.isHidden = alpha != 1
            
        case .scale:
            scale(alpha: alpha)
            
        case .paralaxWithScale:
            scale(alpha: alpha)
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
    
    private func transition(alpha: CGFloat) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.titleView?.alpha = alpha
            self?.titleView?.transform = CGAffineTransform(translationX: 0, y: -alpha*10)
        }
    }
    
    private func scale(alpha: CGFloat) {
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.titleView?.alpha = alpha
            self?.titleView?.transform = CGAffineTransform(scaleX: alpha, y: alpha)
        }
    }
}
