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

import UIKit
import TIUIElements
import TIUIKitCore

open class BaseFilterRangeView<ViewModel: RangeFilterViewModelProtocol>: BaseInitializableControl,
                                                                         FilterRangeViewRepresenter {

    // MARK: - Private properties
    
    private let layout: RangeFilterLayout
    private var contentEdgesConstraints: EdgeConstraints?
    private var toTextFieldWidthConstraint: NSLayoutConstraint?
    private var fromTextFieldWidthConstraint: NSLayoutConstraint?
    private var textFieldsHeightConstraint: NSLayoutConstraint?

    // MARK: - Public properties

    public let formatter: RangeValuesFormatterProtocol
    public let rangeSlider: BaseFilterRangeSlider

    public let textFieldsContainer = UIView()
    public let fromValueView = BaseIntervalInputView(state: .fromValue)
    public let toValueView = BaseIntervalInputView(state: .toValue)

    public var viewModel: ViewModel?

    // MARK: - Open properties

    open var rangeSliderValue: FilterRangeValue {
        (rangeSlider.leftValue, rangeSlider.rightValue)
    }

    open var textFieldsValues: FilterRangeValue {
        (min(fromValueView.currentValue, viewModel?.toValue ?? .zero),
         max(toValueView.currentValue, viewModel?.fromValue ?? .zero))
    }
    // MARK: - Text Fields Setup

    open var textFieldsBorderColor: UIColor = .black {
        didSet {
            toValueView.layer.borderColor = textFieldsBorderColor.cgColor
            fromValueView.layer.borderColor = textFieldsBorderColor.cgColor
        }
    }

    open var textFieldsBorderWidth: CGFloat = 1 {
        didSet {
            toValueView.layer.borderWidth = textFieldsBorderWidth
            fromValueView.layer.borderWidth = textFieldsBorderWidth
        }
    }

    open var textFieldsHeight: CGFloat = 32 {
        didSet {
            textFieldsHeightConstraint?.constant = textFieldsHeight
        }
    }

    open var textFieldsContentInsets: UIEdgeInsets = .zero {
        didSet {
            fromValueView.updateContentInsets(textFieldsContentInsets)
            toValueView.updateContentInsets(textFieldsContentInsets)
        }
    }

    open var textFieldsLabelsSpacing: CGFloat = .zero {
        didSet {
            fromValueView.updateLabelsSpacing(textFieldsLabelsSpacing)
            toValueView.updateLabelsSpacing(textFieldsLabelsSpacing)
        }
    }

    open var textFieldsMinWidth: CGFloat = 40 {
        didSet {
            toTextFieldWidthConstraint?.constant = textFieldsMinWidth
            fromTextFieldWidthConstraint?.constant = textFieldsMinWidth
        }
    }

    open var fontColor: UIColor = .black {
        didSet {
            toValueView.fontColor = fontColor
            fromValueView.fontColor = fontColor
            rangeSlider.fontColor = fontColor
        }
    }

    open var contentSpacing: CGFloat = .zero {
        didSet {
            if layout == .textFieldsOnTop {
                contentEdgesConstraints?.bottomConstraint.constant -= contentSpacing
            } else {
                contentEdgesConstraints?.topConstraint.constant += contentSpacing
            }
        }
    }

    open var leadingInset: CGFloat = .zero {
        didSet {
            contentEdgesConstraints?.leadingConstraint.constant += leadingInset
        }
    }

    open var trailingInset: CGFloat = .zero {
        didSet {
            contentEdgesConstraints?.trailingConstraint.constant -= trailingInset
        }
    }

    open var appearance: DefaultRangeFilterAppearance = .init() {
        didSet {
            updateAppearance()
        }
    }

    // MARK: - Init

    public init(layout: RangeFilterLayout = .textFieldsOnTop,
                formatter: RangeValuesFormatterProtocol = BaseRangeValuesFormatter(),
                viewModel: ViewModel) {

        self.viewModel = viewModel
        self.layout = layout
        self.formatter = formatter
        self.rangeSlider = BaseFilterRangeSlider(layout: layout)

        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    open override func addViews() {
        super.addViews()

        textFieldsContainer.addSubviews(fromValueView, toValueView)
        addSubviews(textFieldsContainer, rangeSlider)
    }

    open override func configureLayout() {
        super.configureLayout()

        [textFieldsContainer, rangeSlider, toValueView, fromValueView]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        switch layout {
        case .textFieldsOnTop:
            configureTextFieldOnTop()
        case .textFieldsFromBelow:
           configureTextFieldFromBelow()
        }

        guard let contentEdgesConstraints = contentEdgesConstraints else {
            return
        }

        let toTextFieldWidthConstraint = toValueView.widthAnchor.constraint(greaterThanOrEqualToConstant: textFieldsMinWidth)
        let fromTextFieldWidthConstraint = fromValueView.widthAnchor.constraint(greaterThanOrEqualToConstant: textFieldsMinWidth)

        NSLayoutConstraint.activate(
            contentEdgesConstraints.allConstraints
            +
            [
                toTextFieldWidthConstraint,
                fromTextFieldWidthConstraint,

                toValueView.trailingAnchor.constraint(equalTo: textFieldsContainer.trailingAnchor),
                toValueView.topAnchor.constraint(equalTo: textFieldsContainer.topAnchor),
                toValueView.bottomAnchor.constraint(equalTo: textFieldsContainer.bottomAnchor),
                fromValueView.leadingAnchor.constraint(equalTo: textFieldsContainer.leadingAnchor),
                fromValueView.topAnchor.constraint(equalTo: textFieldsContainer.topAnchor),
                fromValueView.bottomAnchor.constraint(equalTo: textFieldsContainer.bottomAnchor),

                rangeSlider.leadingAnchor.constraint(equalTo: textFieldsContainer.leadingAnchor),
                rangeSlider.trailingAnchor.constraint(equalTo: textFieldsContainer.trailingAnchor),
                layout == .textFieldsOnTop
                    ? rangeSlider.bottomAnchor.constraint(equalTo: bottomAnchor)
                    : rangeSlider.topAnchor.constraint(equalTo: topAnchor)
            ]
        )

        self.toTextFieldWidthConstraint = toTextFieldWidthConstraint
        self.fromTextFieldWidthConstraint = fromTextFieldWidthConstraint
    }

    open override func bindViews() {
        super.bindViews()

        fromValueView.configure(with: formatter)
        toValueView.configure(with: formatter)
        rangeSlider.configure(with: formatter)

        fromValueView.addTarget(self, valueIsChangedAction: #selector(fromValueIsChanging))
        toValueView.addTarget(self, valueIsChangedAction: #selector(toValueIsChanging))

        fromValueView.addTarget(self, valueDidEndChangingAction: #selector(fromValueDidEndChanging))
        toValueView.addTarget(self, valueDidEndChangingAction: #selector(toValueDidEndChanging))

        rangeSlider.addTarget(self,
                              action: #selector(rangeSliderValueIsChanging),
                              for: .valueChanged)

        rangeSlider.addTarget(self,
                              action: #selector(rangeSliderValueDidEndChanging),
                              for: .editingDidEnd)
    }

    open override func configureAppearance() {
        super.configureAppearance()

        defaultConfigure()
        updateAppearance()

        layoutSubviews()
    }

    // MARK: - Configuration

    open func defaultConfigure() {
        guard let viewModel = viewModel else {
            return
        }

        fromValueView.configure(with: viewModel.initialFromValue ?? viewModel.fromValue)
        toValueView.configure(with: viewModel.initialToValue ?? viewModel.toValue)

        rangeSlider.minimumValue = CGFloat(viewModel.fromValue)
        rangeSlider.maximumValue = CGFloat(viewModel.toValue)

        rangeSlider.leftValue = CGFloat(viewModel.initialFromValue ?? viewModel.fromValue)
        rangeSlider.rightValue = CGFloat(viewModel.initialToValue ?? viewModel.toValue)

        rangeSlider.addStep(stepValues: viewModel.stepValues.map { CGFloat($0) })
    }

    // MARK: - FilterRangeViewRepresenter

    open func configureTextFields(with values: FilterRangeValue) {
        toValueView.configure(with: values.toValue)
        fromValueView.configure(with: values.fromValue)
    }

    open func configureRangeView(with values: FilterRangeValue) {
        rangeSlider.configure(with: values)
    }

    // MARK: - Private methods

    private func updateAppearance() {
        let intervalAppearance = appearance.intervalInputAppearance
        let sliderAppearance = appearance.stepSliderAppearance

        contentSpacing = appearance.spacing
        leadingInset = appearance.leadingSpacing
        trailingInset = appearance.trailingSpacing
        fontColor = appearance.fontColor

        textFieldsHeight = intervalAppearance.textFieldsHeight
        textFieldsMinWidth = intervalAppearance.textFieldsWidth
        textFieldsContentInsets = intervalAppearance.textFieldContentInsets
        textFieldsLabelsSpacing = intervalAppearance.textFieldLabelsSpacing
        textFieldsBorderColor = intervalAppearance.textFieldsBorderColor
        textFieldsBorderWidth = intervalAppearance.textFieldsBorderWidth

        rangeSlider.sliderColor = sliderAppearance.sliderColor
        rangeSlider.sliderOffColor = sliderAppearance.sliderOffColor
        rangeSlider.thumbSize = sliderAppearance.thumbSize
    }

    private func configureTextFieldOnTop() {
        contentEdgesConstraints = EdgeConstraints(leadingConstraint: textFieldsContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
                                                  trailingConstraint: textFieldsContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
                                                  topConstraint: textFieldsContainer.topAnchor.constraint(equalTo: topAnchor),
                                                  bottomConstraint: textFieldsContainer.bottomAnchor.constraint(equalTo: rangeSlider.topAnchor))
    }

    private func configureTextFieldFromBelow() {
        contentEdgesConstraints = EdgeConstraints(leadingConstraint: textFieldsContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
                                                  trailingConstraint: textFieldsContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
                                                  topConstraint: textFieldsContainer.topAnchor.constraint(equalTo: rangeSlider.bottomAnchor),
                                                  bottomConstraint: textFieldsContainer.bottomAnchor.constraint(equalTo: bottomAnchor))
    }

    // MARK: - Actions

    @objc private func rangeSliderValueIsChanging() {
        viewModel?.rangeSliderValueIsChanging(rangeSliderValue)
    }

    @objc private func rangeSliderValueDidEndChanging() {
        viewModel?.rangeSliderValueDidEndChanging(rangeSliderValue)
    }

    @objc private func fromValueIsChanging() {
        viewModel?.fromValueIsChanging(textFieldsValues)
    }

    @objc private func toValueIsChanging() {
        viewModel?.toValueIsChanging(textFieldsValues)
    }

    @objc private func fromValueDidEndChanging() {
        viewModel?.fromValueDidEndChanging(textFieldsValues)
    }

    @objc private func toValueDidEndChanging() {
        viewModel?.toValueDidEndChanging(textFieldsValues)
    }
}
