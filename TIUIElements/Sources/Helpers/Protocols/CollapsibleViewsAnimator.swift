import UIKit

public typealias CollapsibleViewsHolder = TableViewHolder & NavigationBarHolder

public protocol CollapsibleViewsAnimator {
    var fractionComplete: CGFloat { get set } // progress of animation
    
    func setupView(holder: CollapsibleViewsHolder, container: CollapsibleViewsContainer)
    func animate(holder: CollapsibleViewsHolder)
}
