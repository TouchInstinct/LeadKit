import UIKit

public protocol CollapsibleViewsContainer {
    var topHeaderView: UIView? { get } // titleView
    var bottomHeaderView: UIView? { get } // tableHeaderView

    var fixedTopOffet: CGFloat { get } // status bar + nav bar height
}
