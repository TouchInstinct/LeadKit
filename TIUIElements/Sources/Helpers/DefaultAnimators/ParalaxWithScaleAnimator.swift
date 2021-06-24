import UIKit

final public class ParalaxWithScaleAnimator: CollapsibleViewsAnimator {
    private let paralaxAnimator = ParalaxAnimator(isWithAlphaAnimate: false)
    private let scaleAnimator = ScaleAnimator()
    
    public var fractionComplete: CGFloat = 0 {
        didSet {
            paralaxAnimator.fractionComplete = fractionComplete
            scaleAnimator.fractionComplete = fractionComplete
        }
    }
    
    public func setupView(holder: CollapsibleViewsHolder, container: CollapsibleViewsContainer) {
        paralaxAnimator.setupView(holder: holder, container: container)
        scaleAnimator.setupView(holder: holder, container: container)
    }
    
    public func animate(holder: CollapsibleViewsHolder) {
        paralaxAnimator.animate(holder: holder)
        scaleAnimator.animate(holder: holder)
    }
}
