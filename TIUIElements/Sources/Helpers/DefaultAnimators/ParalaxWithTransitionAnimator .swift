import UIKit

final public class ParalaxWithTransitionAnimator: CollapsibleViewsAnimator {
    private let paralaxAnimator: ParalaxAnimator
    private let transitionAnimator: TransitionAnimator
    
    public var fractionComplete: CGFloat = 0 {
        didSet {
            paralaxAnimator.fractionComplete = fractionComplete
            transitionAnimator.fractionComplete = fractionComplete
        }
    }

    public var currentContentOffset: CGPoint {
        didSet {
            paralaxAnimator.currentContentOffset = currentContentOffset
            transitionAnimator.currentContentOffset = currentContentOffset
        }
    }

    public init(tableHeaderView: ParallaxTableHeaderView,
                navBar: UINavigationBar? = nil,
                currentContentOffset: CGPoint) {
        paralaxAnimator = ParalaxAnimator(tableHeaderView: tableHeaderView,
                                          navBar: nil,
                                          currentContentOffset: currentContentOffset)
        transitionAnimator = TransitionAnimator(navBar: navBar)
        self.currentContentOffset = currentContentOffset
    }
}
