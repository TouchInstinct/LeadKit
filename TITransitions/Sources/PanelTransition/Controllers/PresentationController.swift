//
//  Copyright (c) 2020 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

open class PresentationController: UIPresentationController {
    private let presentStyle: PresentStyle
    private let driver: TransitionDriver?
    
    override open var shouldPresentInFullscreen: Bool {
        false
    }
    
    override open var frameOfPresentedViewInContainerView: CGRect {
        calculatePresentedFrame(for: presentStyle)
    }
    
    public init(driver: TransitionDriver?,
                presentStyle: PresentStyle,
                presentedViewController: UIViewController,
                presenting: UIViewController?) {
        self.driver = driver
        self.presentStyle = presentStyle
        super.init(presentedViewController: presentedViewController, presenting: presenting)
    }
    
    override open func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        if let presentedView = presentedView {
            containerView?.addSubview(presentedView)
        }
    }
    
    override open func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override open func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if completed {
            driver?.direction = .dismiss
        }
    }
}

private extension PresentationController {
    func calculatePresentedFrame(for style: PresentStyle) -> CGRect {
        guard let bounds = containerView?.bounds else {
            return .zero
        }
        
        switch style {
        case .fullScreen:
            return CGRect(x: .zero, y: .zero, width: bounds.width, height: bounds.height)
        case .halfScreen:
            let halfHeight = bounds.height / 2
            return CGRect(x: .zero, y: halfHeight, width: bounds.width, height: halfHeight)
        case let .customInsets(insets):
            return calculateCustomFrame(insets: insets)
        case let .customHeight(height):
            return CGRect(x: .zero, y: bounds.height - height, width: bounds.width, height: height)
        }
    }
    
    func calculateCustomFrame(insets: UIEdgeInsets) -> CGRect {
        guard let bounds = containerView?.bounds else {
            return .zero
        }
        
        let origin = CGPoint(x: insets.left, y: insets.top)
        
        let size = CGSize(width: bounds.width - insets.right - insets.left,
                          height: bounds.height - insets.top - insets.bottom)

        return CGRect(origin: origin, size: size)
    }
}
