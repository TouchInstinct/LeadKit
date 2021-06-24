import UIKit

final public class ParalaxWithTransitionAnimator: CollapsibleViewsAnimator {
    private let paralaxAnimator = ParalaxAnimator(isWithAlphaAnimate: false)
    private let transitionAnimator = TransitionAnimator()
    
    public var fractionComplete: CGFloat = 0 {
        didSet {
            paralaxAnimator.fractionComplete = fractionComplete
            transitionAnimator.fractionComplete = fractionComplete
        }
    }
    
    public func setupView(holder: CollapsibleViewsHolder, container: CollapsibleViewsContainer) {
        paralaxAnimator.setupView(holder: holder, container: container)
        transitionAnimator.setupView(holder: holder, container: container)
    }
    
    public func animate(holder: CollapsibleViewsHolder) {
        paralaxAnimator.animate(holder: holder)
        transitionAnimator.animate(holder: holder)
    }
}
