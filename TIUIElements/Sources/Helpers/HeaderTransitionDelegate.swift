import Foundation
import UIKit

public protocol HeaderViewHandlerProtocol: UIViewController {
    var largeHeaderView: UIView? { get }
    var headerView: UIView? { get }
    var tableView: UITableView { get }
}

open class HeaderTransitionDelegate: NSObject {
    
    private var navigationBarHeight: CGFloat = 0
    private var startOffset: CGFloat = 0
    private var statusBarHeight: CGFloat = 0
    private var isStartSet = true
    
    private weak var headerViewHandler: HeaderViewHandlerProtocol?
    
    public init(headerViewHandler: HeaderViewHandlerProtocol) {
        self.headerViewHandler = headerViewHandler
        super.init()
        
        initialUpdateHeaderView()
    }
    
    private func initialUpdateHeaderView() {
        headerViewHandler?.navigationController?.navigationBar.topItem?.titleView = headerViewHandler?.headerView
        headerViewHandler?.navigationController?.navigationBar.topItem?.titleView?.isHidden = true

        headerViewHandler?.tableView.tableHeaderView = headerViewHandler?.largeHeaderView
    }
}

extension HeaderTransitionDelegate: UITableViewDelegate {
    open func scrollViewDidScrollHandler(_ scrollView: UIScrollView) {
        guard let headerHandler = headerViewHandler,
              let largeHeaderView = headerHandler.largeHeaderView else {
            headerViewHandler?.navigationController?.navigationBar.topItem?.titleView?.isHidden = false
            return
        }
        
        if isStartSet {
            startOffset = -(headerHandler.tableView.contentOffset.y)
            startOffset = startOffset < 0 ? 0 : startOffset
            navigationBarHeight = headerHandler.navigationController?.navigationBar.bounds.height ?? 0
            if #available(iOS 13.0, *) {
                statusBarHeight = headerHandler.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            } else {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
            isStartSet = false
        }

        let prefersLargeTitles = headerHandler.navigationController?.navigationBar.prefersLargeTitles ?? false
        let offsetY = scrollView.contentOffset.y + startOffset
        let navigayionBarOffset = prefersLargeTitles ? navigationBarHeight - statusBarHeight : 0
        let isHidden = offsetY <= (largeHeaderView.frame.height + navigayionBarOffset)
        headerHandler.navigationController?.navigationBar.topItem?.titleView?.isHidden = isHidden
    }
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScrollHandler(scrollView)
    }
}
