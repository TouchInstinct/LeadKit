import UIKit

class ParalaxWithTransitionAnimator: CollapsibleViewsAnimator {
    private let paralaxAnimator = ParalaxAnimator(isWithAlphaAnimate: false)
    private let transitionAnimator = TransitionAnimator()
    
    var fractionComplete: CGFloat = 0 {
        didSet {
            paralaxAnimator.fractionComplete = fractionComplete
            transitionAnimator.fractionComplete = fractionComplete
        }
    }
    
    func setupView(container: CollapsibleViewsContainer) {
        paralaxAnimator.setupView(container: container)
        transitionAnimator.setupView(container: container)
    }
    
    func animate(container: CollapsibleViewsContainer) {
        paralaxAnimator.animate(container: container)
        transitionAnimator.animate(container: container)
    }
}
