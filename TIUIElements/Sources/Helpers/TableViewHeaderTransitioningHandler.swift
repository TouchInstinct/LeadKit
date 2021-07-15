import UIKit

final class TableViewHeaderTransitioningHandler: NSObject, TransitioningHandler {
    var animator: CollapsibleViewsAnimator?

    private var startOffset: CGFloat = 0
    private var navigationBarOffset: CGFloat = 0
    private var isFirstScroll = true

    private var container: CollapsibleViewsContainer?

    init(collapsibleViewsContainer: CollapsibleViewsContainer) {
        self.container = collapsibleViewsContainer
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let largeHeaderView = container?.bottomHeaderView else {
            return
        }

        if isFirstScroll {
            startOffset = max(-(scrollView.contentOffset.y), 0)
            navigationBarOffset = container?.fixedTopOffet ?? 0
            isFirstScroll = false
        }

        let offsetY = scrollView.contentOffset.y + startOffset

        let alpha = min(offsetY / (largeHeaderView.frame.height + navigationBarOffset), 1)

        animator?.fractionComplete = alpha
        animator?.currentContentOffset = scrollView.contentOffset
    }
}
