//
//  Copyright (c) 2022 Touch Instinct
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

import TIUIKitCore
import UIKit

open class BaseFilterRangeSlider: StepRangeSlider {

    private let layout: RangeFilterLayout

    private var stepCircleViews: [UIView] = []
    private var stepLabels: [UILabel] = []

    private(set) var stepValues: [CGFloat] = []

    public var formatter: RangeValuesFormatterProtocol?

    open var numberOfSteps: Int {
        stepValues.count
    }

    open var fontColor: UIColor = .black {
        didSet {
            stepLabels.forEach { $0.textColor = fontColor }
        }
    }

    open var sliderColor: UIColor = .systemOrange {
        didSet {
            stepCircleInColor = sliderColor
            activeTrackColor = sliderColor
            thumbColor = sliderColor
        }
    }

    open var sliderOffColor: UIColor = .darkGray {
        didSet {
            stepCircleOutColor = sliderOffColor
            trackColor = sliderOffColor
        }
    }

    open var stepCircleInColor: UIColor = .systemOrange {
        didSet {
            setNeedsLayout()
        }
    }

    open var stepCircleOutColor: UIColor = .darkGray {
        didSet {
            setNeedsLayout()
        }
    }

    open var stepCircleSize: CGFloat = 5 {
        didSet {
            updateStepViewsRadius()
            setNeedsLayout()
        }
    }

    open override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize

        guard !stepLabels.isEmpty else {
            return superSize
        }

        return .init(width: superSize.width, height: stepLabels[.zero].frame.maxY)
    }

    // MARK: - Init

    public init(layout: RangeFilterLayout) {
        self.layout = layout

        super.init(frame: .zero)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        updateStepCircleViewsPosition()
        updateStepLabelsPosition()
        updateStepViewsColors()
    }

    // MARK: - Open methods

    open func configure(with values: FilterRangeValue) {
        leftValue = CGFloat(values.fromValue)
        rightValue = CGFloat(values.toValue)
    }

    open func configure(with formatter: RangeValuesFormatterProtocol) {
        self.formatter = formatter

        createStepLabels()
    }

    open func addStep(stepValues: [CGFloat]) {
        self.stepValues = stepValues

        createStepCircleViews()
        createStepLabels()
        updateStepViewsRadius()
        updateStepViewsColors()

        setNeedsLayout()
        layoutIfNeeded()
        invalidateIntrinsicContentSize()
    }

    // MARK: - Private methods

    private func createStepCircleViews() {
        stepCircleViews.forEach {
            $0.removeFromSuperview()
        }
        stepCircleViews.removeAll()

        for _ in .zero ..< numberOfSteps {
            let stepCircle = UIView()
            stepCircleViews.append(stepCircle)
        }

        addSubviews(stepCircleViews)

        thumbs.forEach {
            bringSubviewToFront($0)
        }
    }

    private func updateStepCircleViewsPosition() {
        for index in 0 ..< stepCircleViews.count {
            guard index >= .zero && index < stepCircleViews.count else {
                return
            }

            let circle = stepCircleViews[index]

            let positionX = getPositionX(from: stepValues[index]) + (thumbSize - stepCircleSize) / 2
            let positionY = trackView.frame.minY + (trackView.frame.height - stepCircleSize) / 2

            circle.frame = .init(x: positionX,
                                 y: positionY,
                                 width: stepCircleSize,
                                 height: stepCircleSize)
        }
    }

    private func updateStepViewsRadius() {
        stepCircleViews.forEach {
            $0.layer.round(corners: .allCorners, radius: stepCircleSize / 2)
        }
    }

    private func updateStepViewsColors() {
        stepCircleViews.forEach {
            let leftThumbMaxX = leftThumbView.frame.maxX
            let rightThumbMinX = rightThumbView.frame.minX
            let isEnterRange = $0.frame.maxX >= leftThumbMaxX && $0.frame.minX <= rightThumbMinX
            $0.backgroundColor = isEnterRange ? stepCircleInColor : stepCircleOutColor
        }
    }

    private func createStepLabels() {
        guard let formatter = formatter else { return }

        stepLabels.forEach {
            $0.removeFromSuperview()
        }

        stepValues.forEach {
            let label = UILabel()
            let formattedText = formatter.string(fromDouble: $0)
            label.text = formattedText

            stepLabels.append(label)
        }

        addSubviews(stepLabels)
    }

    private func updateStepLabelsPosition() {
        for (index, label) in stepLabels.enumerated() {
            guard index >= .zero && index < stepCircleViews.count else {
                return
            }

            let circleView = stepCircleViews[index]
            let yPosition = layout == .textFieldsOnTop
                ? circleView.frame.maxY
                : circleView.frame.minY - label.bounds.height

            label.center.x = circleView.center.x
            label.sizeToFit()
            label.frame = .init(x: label.frame.minX,
                                y: yPosition,
                                width: label.bounds.width,
                                height: label.bounds.height)
        }
    }

    private func getStepCirclePositionX(_ value: CGFloat) -> CGFloat {
        let unit = trackUsingWidth / (maximumValue - minimumValue)
        return (value - minimumValue) * unit
    }
}
