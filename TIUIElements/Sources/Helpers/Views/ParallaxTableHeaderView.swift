import Foundation
import UIKit

open class ParallaxTableHeaderView: UIView {
    private var container: UIView
    
    public init(wrappedView: UIView) {
        container = UIView(frame: wrappedView.frame)
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: wrappedView.frame.size.width,
                                 height: wrappedView.frame.size.height))
        wrappedView.autoresizingMask = [
            .flexibleLeftMargin,
            .flexibleRightMargin,
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleHeight,
            .flexibleWidth
        ]
        container.addSubview(wrappedView)
        addSubview(container)
        
        clipsToBounds = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func layout(for contentOffset: CGPoint) {
        guard contentOffset.y <= 0 else {
            return
        }
        
        let delta: CGFloat = abs(contentOffset.y)
        var rect = frame
        rect.origin = .zero
        rect.origin.y -= delta
        rect.size.height += delta
        container.frame = rect
    }
}
