import UIKit

class ParalaxWithScaleAnimator: CollapsibleViewsAnimator {
    private let paralaxAnimator = ParalaxAnimator(isWithAlphaAnimate: false)
    private let scaleAnimator = ScaleAnimator()
    
    var fractionComplete: CGFloat = 0 {
        didSet {
            paralaxAnimator.fractionComplete = fractionComplete
            scaleAnimator.fractionComplete = fractionComplete
        }
    }
    
    func setupView(container: CollapsibleViewsContainer) {
        paralaxAnimator.setupView(container: container)
        scaleAnimator.setupView(container: container)
    }
    
    func animate(container: CollapsibleViewsContainer) {
        paralaxAnimator.animate(container: container)
        scaleAnimator.animate(container: container)
    }
}
