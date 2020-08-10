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

open class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Presentation controller
    private let driver: TransitionDriver?
    private let presentStyle: PresentStyle
    private let presentAnimation: PresentAnimation
    private let dismissAnimation: DismissAnimation
    private let panelConfig: PanelPresentationController.Configuration
    
    public init(presentStyle: PresentStyle,
                panelConfig: PanelPresentationController.Configuration = .default,
                driver: TransitionDriver? = .init(),
                presentAnimation: PresentAnimation = .init(),
                dismissAnimation: DismissAnimation = .init()) {
        self.presentStyle = presentStyle
        self.driver = driver
        self.presentAnimation = presentAnimation
        self.dismissAnimation = dismissAnimation
        self.panelConfig = panelConfig
        super.init()
    }
    
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        driver?.link(to: presented)
        
        let presentationController = PanelPresentationController(config: panelConfig,
                                                                 driver: driver,
                                                                 presentStyle: presentStyle,
                                                                 presentedViewController: presented,
                                                                 presenting: presenting ?? source)
        return presentationController
    }
    
    // MARK: - Animation
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        dismissAnimation
    }
    
    // MARK: - Interaction
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        driver
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        driver
    }
}
