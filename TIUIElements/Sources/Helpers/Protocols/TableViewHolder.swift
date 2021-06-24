import UIKit

public protocol TableViewHolder {
    var tableView: UITableView { get }
}

public extension TableViewHolder {
    var startOffset: CGPoint {
        tableView.contentOffset
    }
}
