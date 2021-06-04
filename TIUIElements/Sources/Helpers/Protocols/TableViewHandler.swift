import UIKit

public protocol TableViewHandler {
    var tableView: UITableView { get }
}

extension TableViewHandler {
    var startOffset: CGFloat {
        max(-(tableView.contentOffset.y), 0)
    }
}
