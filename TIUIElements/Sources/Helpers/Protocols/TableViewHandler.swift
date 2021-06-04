import UIKit

public protocol TableViewHandler {
    var tableView: UITableView { get }
}

extension TableViewHandler {
    var startOffset: CGPoint {
        tableView.contentOffset
    }
}
