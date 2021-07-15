import UIKit

public protocol TransitioningHandler: UIScrollViewDelegate {
    var animator: CollapsibleViewsAnimator? { get set }

    init(collapsibleViewsContainer: CollapsibleViewsContainer)
}
