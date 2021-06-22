import UIKit

public protocol TransitioningHandler: UIScrollViewDelegate {
    var animator: CollapsibleViewsAnimator? { get set }

    init(container: CollapsibleViewsContainer,
         animator: CollapsibleViewsAnimator?)
}
