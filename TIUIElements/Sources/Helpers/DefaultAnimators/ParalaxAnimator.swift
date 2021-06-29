import UIKit

final public class ParalaxAnimator: CollapsibleViewsAnimator {
    public var fractionComplete: CGFloat = 0 {
        didSet {
            navBar?.topItem?.titleView?.alpha = fractionComplete == 1 ? 1 : 0
        }
    }

    public var currentContentOffset: CGPoint {
        didSet {
            tableHeaderView?.layout(for: currentContentOffset)
        }
    }

    private weak var navBar: UINavigationBar?
    private weak var tableHeaderView: ParallaxTableHeaderView?

    public init(tableHeaderView: ParallaxTableHeaderView,
                navBar: UINavigationBar? = nil,
                currentContentOffset: CGPoint) { // if nil - no alpha animation
        self.currentContentOffset = currentContentOffset
        self.tableHeaderView = tableHeaderView
        self.navBar = navBar
    }
}
