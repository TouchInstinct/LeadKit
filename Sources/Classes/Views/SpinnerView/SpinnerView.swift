//
//  Copyright (c) 2017 Touch Instinct
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

public final class SpinnerView: UIView, Animatable, LoadingIndicator {

    private(set) var animating: Bool = false
    private var startTime = CFTimeInterval(0)
    private var stopTime = CFTimeInterval(0)

    private weak var imageView: UIImageView?

    private let animationDuration: CFTimeInterval
    private let animationRepeatCount: Float
    private let clockwiseAnimation: Bool

    public init(image: UIImage,
                animationDuration: CFTimeInterval = 1,
                animationRepeatCount: Float = Float.infinity,
                clockwiseAnimation: Bool = true) {

        self.animationDuration = animationDuration
        self.animationRepeatCount = animationRepeatCount
        self.clockwiseAnimation = clockwiseAnimation

        super.init(frame: CGRect(origin: .zero, size: image.size))

        let imageView = UIImageView(image: image)
        imageView.frame = bounds
        imageView.autoresizingMask = [
            .flexibleLeftMargin,
            .flexibleRightMargin,
            .flexibleTopMargin,
            .flexibleBottomMargin
        ]

        addSubview(imageView)

        self.imageView = imageView

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SpinnerView.restartAnimationIfNeeded),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override public func didMoveToWindow() {
        super.didMoveToWindow()

        if window != nil {
            restartAnimationIfNeeded()
        }
    }

    // MARK: - Animatable

    @objc public func startAnimating() {
        guard !animating else {
            return
        }

        animating = true

        imageView?.isHidden = false

        addAnimation()
    }

    @objc public func stopAnimating() {
        guard animating else {
            return
        }

        animating = false

        imageView?.isHidden = true

        removeAnimation()
    }

    // MARK: - private stuff

    private func addAnimation() {
        guard let imageView = imageView else {
            return
        }

        let anim = CABasicAnimation.zRotationAnimationWith(duration: animationDuration,
                                                           repeatCount: animationRepeatCount,
                                                           clockwise: clockwiseAnimation)
        anim.timeOffset = stopTime - startTime

        imageView.layer.add(anim, forKey: CABasicAnimation.rotationKeyPath)

        startTime = imageView.layer.convertTime(CACurrentMediaTime(), from: nil)
    }

    private func removeAnimation() {
        guard let imageView = imageView else {
            return
        }

        imageView.layer.removeAnimation(forKey: CABasicAnimation.rotationKeyPath)

        stopTime = imageView.layer.convertTime(CACurrentMediaTime(), from: nil)
    }

    @objc private func restartAnimationIfNeeded() {
        if animating {
            removeAnimation()
            addAnimation()
        }
    }

}
