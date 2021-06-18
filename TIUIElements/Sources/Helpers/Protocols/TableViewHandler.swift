import UIKit

public protocol TableViewHandler {
    var tableView: UITableView { get }
}

public extension TableViewHandler {
    var startOffset: CGPoint {
        tableView.contentOffset
    }
}
