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

import TISwiftUtils
import UIKit

open class SkeletonsConfiguration {

    public var viewConfiguration: BaseViewSkeletonsConfiguration
    public var labelConfiguration: LabelSkeletonsConfiguration
    public var imageViewConfiguration: BaseViewSkeletonsConfiguration
    public var animation: Closure<SkeletonLayer, CAAnimationGroup>?

    public var skeletonsBackgroundColor: CGColor
    public var skeletonsMovingColor: CGColor
    public var borderWidth: CGFloat

    public weak var configurationDelegate: SkeletonsConfigurationDelegate?

    open var isContainersHidden: Bool {
        borderWidth == .zero
    }

    // MARK: - Init

    public init(viewConfiguration: BaseViewSkeletonsConfiguration = .init(),
                labelConfiguration: LabelSkeletonsConfiguration = .init(),
                imageViewConfiguration: BaseViewSkeletonsConfiguration = .init(shape: .circle),
                animation: Closure<SkeletonLayer, CAAnimationGroup>? = nil,
                skeletonsBackgroundColor: UIColor = .lightGray.withAlphaComponent(0.7),
                borderWidth: CGFloat = .zero,
                configurationDelegate: SkeletonsConfigurationDelegate? = nil) {

        self.viewConfiguration = viewConfiguration
        self.labelConfiguration = labelConfiguration
        self.imageViewConfiguration = imageViewConfiguration
        self.animation = animation
        self.skeletonsBackgroundColor = skeletonsBackgroundColor.cgColor
        self.skeletonsMovingColor = skeletonsBackgroundColor.withAlphaComponent(0.2).cgColor
        self.borderWidth = borderWidth
        self.configurationDelegate = configurationDelegate
    }

    // MARK: - Open methods

    open func createSkeletonLayer(for baseView: UIView?) -> SkeletonLayer {
        SkeletonLayer(config: self, baseView: baseView)
    }

    open func configureAppearance(layer: SkeletonLayer) {
        layer.fillColor = skeletonsBackgroundColor
    }

    open func configureContainerAppearance(layer: SkeletonLayer) {
        layer.fillColor = UIColor.clear.cgColor

        if !isContainersHidden {
            layer.borderColor = skeletonsBackgroundColor
            layer.borderWidth = borderWidth

            if case let .rectangle(cornerRadius: radius) = viewConfiguration.shape {
                layer.cornerRadius = radius
            }
        }
    }

    open func configureAppearance(gradientLayer: CAGradientLayer) {
        gradientLayer.colors = [
            skeletonsBackgroundColor,
            skeletonsMovingColor,
            skeletonsBackgroundColor,
        ]
    }
}
