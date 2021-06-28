import UIKit

public protocol CollapsibleViewsAnimator {
   var fractionComplete: CGFloat { get set } // progress of animation
   var currentContentOffset: CGPoint { get set } // offset on content in table view/collection view or plain scroll view
}
