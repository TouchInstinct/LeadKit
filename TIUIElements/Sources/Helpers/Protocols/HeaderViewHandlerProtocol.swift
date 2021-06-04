import UIKit

public protocol HeaderViewHandlerProtocol: class, TableViewHandler & NavigationBarСalculated {
    var largeHeaderView: UIView? { get }
    var headerView: UIView? { get }
}
