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

open class PanelPresentationController: PresentationController {
    private let config: Configuration
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = config.backgroundColor
        view.alpha = 0
        return view
    }()
    
    public init(config: Configuration,
                driver: TransitionDriver?,
                presentStyle: PresentStyle,
                presentedViewController: UIViewController,
                presenting: UIViewController?) {
        self.config = config
        super.init(driver: driver,
                   presentStyle: presentStyle,
                   presentedViewController: presentedViewController,
                   presenting: presenting)
        
        if config.onTapDismissEnabled {
            configureOnTapClose()
        }
    }
    
    override open func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView?.insertSubview(backView, at: 0)

        performAlongsideTransitionIfPossible { [weak self] in
            self?.backView.alpha = 1
        }
    }
    
    override open func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        backView.frame = containerView?.frame ?? .zero
    }
    
    override open func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if !completed {
            backView.removeFromSuperview()
        }
    }
    
    override open func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        performAlongsideTransitionIfPossible { [weak self] in
            self?.backView.alpha = .zero
        }
    }
    
    override open func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            backView.removeFromSuperview()
        }
    }
    
    private func configureOnTapClose() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        backView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func onTapClose() {
        presentedViewController.dismiss(animated: true, completion: config.onTapDismissCompletion)
    }
    
    private func performAlongsideTransitionIfPossible(_ block: @escaping () -> Void) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            block()
            return
        }
            
        coordinator.animate(alongsideTransition: { _ in
            block()
        })
    }
}

extension PanelPresentationController {
    public struct Configuration {
        public let backgroundColor: UIColor
        public let onTapDismissEnabled: Bool
        public let onTapDismissCompletion: VoidClosure?
        
        public init(backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.4),
                    onTapDismissEnabled: Bool = true,
                    onTapDismissCompletion: VoidClosure? = nil) {
            self.backgroundColor = backgroundColor
            self.onTapDismissEnabled = onTapDismissEnabled
            self.onTapDismissCompletion = onTapDismissCompletion
        }
        
        public static let `default`: Configuration = .init()
    }
}
