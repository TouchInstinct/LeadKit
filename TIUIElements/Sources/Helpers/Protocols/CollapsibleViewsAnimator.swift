import UIKit

public protocol CollapsibleViewsAnimator {
    var fractionComplete: CGFloat { get set } // progress of animation
    
    func setupView(container: CollapsibleViewsContainer)
    func animate(container: CollapsibleViewsContainer)
}
