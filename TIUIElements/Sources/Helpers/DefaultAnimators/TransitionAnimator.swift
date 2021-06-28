import UIKit

final public class TransitionAnimator: CollapsibleViewsAnimator {
    public var fractionComplete: CGFloat = 0 {
        didSet {
            navBar?.topItem?.titleView?.transition(to: fractionComplete)
        }
    }

    public var currentContentOffset = CGPoint.zero

    private weak var navBar: UINavigationBar?

    public init(navBar: UINavigationBar? = nil) {
        navBar?.topItem?.titleView?.alpha = 0
        self.navBar = navBar
    }
}
