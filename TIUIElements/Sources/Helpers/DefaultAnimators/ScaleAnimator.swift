import UIKit

final public class ScaleAnimator: CollapsibleViewsAnimator {
    public var fractionComplete: CGFloat = 0 {
        didSet {
            navBar?.topItem?.titleView?.scale(to: fractionComplete)
        }
    }

    public var currentContentOffset = CGPoint.zero

    private weak var navBar: UINavigationBar?

    public init(navBar: UINavigationBar? = nil) {
        self.navBar = navBar
        navBar?.topItem?.titleView?.alpha = 0
        navBar?.topItem?.titleView?.transform = CGAffineTransform(scaleX: -0.5, y: 0.5)
    }
}
