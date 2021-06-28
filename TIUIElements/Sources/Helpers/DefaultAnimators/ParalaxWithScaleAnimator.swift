import UIKit

final public class ParalaxWithScaleAnimator: CollapsibleViewsAnimator {
    private let paralaxAnimator: ParalaxAnimator
    private let scaleAnimator: ScaleAnimator
    
    public var fractionComplete: CGFloat = 0 {
        didSet {
            paralaxAnimator.fractionComplete = fractionComplete
            scaleAnimator.fractionComplete = fractionComplete
        }
    }

    public var currentContentOffset: CGPoint {
        didSet {
            paralaxAnimator.currentContentOffset = currentContentOffset
            scaleAnimator.currentContentOffset = currentContentOffset
        }
    }

    private weak var navBar: UINavigationBar?

    public init(tableHeaderView: ParallaxTableHeaderView, navBar: UINavigationBar? = nil, currentContentOffset: CGPoint) {
        self.navBar = navBar
        paralaxAnimator = ParalaxAnimator(tableHeaderView: tableHeaderView, navBar: nil, currentContentOffset: currentContentOffset)
        scaleAnimator = ScaleAnimator(navBar: navBar)
        self.currentContentOffset = currentContentOffset
    }
}
