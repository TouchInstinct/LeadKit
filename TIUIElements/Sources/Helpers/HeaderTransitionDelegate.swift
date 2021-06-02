import Foundation
import UIKit

open protocol HeaderViewHandlerProtocol: UIViewController {
    var largeHeaderView: UIView? { get }
    var headerView: UIView? { get }
    var tableView: UITableView { get }
    
    func configureHeaderViews()
}

extension HeaderViewHandlerProtocol {
    func configureHeaderViews() {}
}

open class HeaderTransitionDelegate: NSObject {
    
    private var navigationBarHeight: CGFloat = 0
    private var startOffset: CGFloat = 0
    private var statusBarHeight: CGFloat = 0
    private var isStartSet = true
    
    private weak var headerViewHandler: HeaderViewHandlerProtocol?
    
    init(headerViewHandler: HeaderViewHandlerProtocol) {
        self.headerViewHandler = headerViewHandler
        super.init()
        
        initialUpdateHeaderView()
    }

    open func updateHeaderView(isNavigationTitleView: Bool = false) {
        headerViewHandler?.configureHeaderViews()
        headerViewHandler?.navigationController?.navigationBar.topItem?.titleView?.isHidden = !isNavigationTitleView
    }

    private func initialUpdateHeaderView() {
        
        headerViewHandler?.navigationController?.navigationBar.topItem?.titleView = headerViewHandler?.headerView
        headerViewHandler?.headerView?.isHidden = true

        headerViewHandler?.tableView.tableHeaderView = headerViewHandler?.largeHeaderView
        
        headerViewHandler?.tableView.delegate = self

        updateHeaderView(isNavigationTitleView: false)
        
    }
}

extension HeaderTransitionDelegate: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerHandler = headerViewHandler,
              let largeHeaderView = headerHandler.largeHeaderView else {
            headerViewHandler?.navigationController?.navigationBar.topItem?.titleView?.isHidden = false
            return
        }
        
        if isStartSet {
            startOffset = -(headerHandler.tableView.contentOffset.y)
            navigationBarHeight = headerHandler.navigationController?.navigationBar.bounds.height ?? 0
            if #available(iOS 13.0, *) {
                statusBarHeight = headerHandler.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            } else {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
            isStartSet = false
        }

        let offsetY = scrollView.contentOffset.y + startOffset
          
        let isHidden = offsetY <= (largeHeaderView.frame.height + navigationBarHeight - statusBarHeight)
        headerHandler.navigationController?.navigationBar.topItem?.titleView?.isHidden = isHidden
    }
}
