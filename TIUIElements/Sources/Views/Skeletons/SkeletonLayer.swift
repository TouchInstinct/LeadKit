//
//  Copyright (c) 2023 Touch Instinct
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

open class SkeletonLayer: CAShapeLayer {

    private enum Constants {
        static var animationKeyPath: String {
            "skeletonAnimation"
        }
    }

    public enum ViewType {
        case generic(UIView)
        case container(UIView)
        case label(UILabel)
        case textView(UITextView)
        case imageView(UIImageView)

        public var view: UIView {
            switch self {
            case let .imageView(imageView):
                return imageView

            case let .container(containerView):
                return containerView

            case let .label(labelView):
                return labelView

            case let .textView(textView):
                return textView

            case let .generic(view):
                return view
            }
        }
    }

    private var animationLayer = CAGradientLayer()
    private var viewBoundsObservation: NSKeyValueObservation?

    public var configuration: SkeletonsConfiguration
    public weak var baseView: UIView?

    // MARK: - Init

    // For debug purposes in Lookin or other programs for view hierarchy inspections
    public override init(layer: Any) {
        self.configuration = .init()

        super.init(layer: layer)
    }

    public init(config: SkeletonsConfiguration, baseView: UIView?) {
        self.configuration = config
        self.baseView = baseView

        super.init()
    }

    public required init?(coder: NSCoder) {
        self.configuration = .init()

        super.init(coder: coder)
    }

    // MARK: - Open methods

    open func bind(to viewType: ViewType) {
        configureAppearance(viewType)
        updateGeometry(viewType: viewType)

        viewBoundsObservation = viewType.view.observe(\.frame, options: [.new]) { [weak self] view, _ in
            view.isHidden = true
            self?.updateGeometry(viewType: view.viewType)
        }

        configuration.configurationDelegate?.layerDidConfigured(forViewType: viewType, layer: self)
    }

    open func remove(from view: UIView) {
        stopAnimation()
        removeFromSuperlayer()
        viewBoundsObservation = nil
    }

    open func startAnimation() {
        guard let animation = configuration.animation?(self) else {
            return
        }

        animationLayer.add(animation, forKey: Constants.animationKeyPath)
        mask = animationLayer
    }

    open func stopAnimation() {
        animationLayer.removeAllAnimations()
        mask?.removeFromSuperlayer()
    }

    // MARK: - Private methods

    private func configureAppearance(_ type: ViewType) {
        switch type {
        case .container(_):
            configuration.configureContainerAppearance(layer: self)

        default:
            configuration.configureAppearance(layer: self)
        }

        configuration.configureAppearance(gradientLayer: animationLayer)
    }

    private func updateGeometry(viewType: ViewType) {
        frame = viewType.view.convert(viewType.view.bounds, to: baseView)
        path = drawPath(viewType: viewType)
        animationLayer.frame = bounds
    }

    private func drawPath(viewType: ViewType) -> CGPath {
        var path: CGPath

        switch viewType {
        case let .textView(textView):
            path = configuration.labelConfiguration.configureTextViewPath(textView: textView)

        case let .label(label):
            path = configuration.labelConfiguration.configureLabelPath(label: label)

        case .imageView(_):
            path = configuration.imageViewConfiguration.drawPath(rect: viewType.view.bounds)

        default:
            path = configuration.viewConfiguration.drawPath(rect: viewType.view.bounds)
        }

        return path
    }
}
