import Foundation
import UIKit

open class ParallaxTableHeaderView: UIView {
    private var container: UIView
    
    public init(subView: UIView) {
        container = UIView(frame: subView.frame)
        super.init(frame: CGRect(x: 0, y: 0, width: subView.frame.size.width, height: subView.frame.size.height))
    
        subView.autoresizingMask = [
            .flexibleLeftMargin,
            .flexibleRightMargin,
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleHeight,
            .flexibleWidth
        ]
        container.addSubview(subView)
        addSubview(container)
        clipsToBounds = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func layoutForContentOffset(_ contentOffset: CGPoint) {
        guard contentOffset.y <= 0 else {
            return
        }
        
        let delta: CGFloat = abs(contentOffset.y)
        var rect: CGRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        rect.origin.y -= delta
        rect.size.height += delta
        container.frame = rect
    }
}
