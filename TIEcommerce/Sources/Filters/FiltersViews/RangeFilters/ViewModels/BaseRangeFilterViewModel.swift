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

import CoreGraphics
import Foundation
import TISwiftUtils

public typealias FilterRangeValue = (fromValue: CGFloat, toValue: CGFloat)

open class BaseRangeFilterViewModel: RangeFilterViewModelProtocol {

    public let fromValue: CGFloat
    public let toValue: CGFloat
    public let stepValues: [CGFloat]

    public var initialFromValue: CGFloat?
    public var initialToValue: CGFloat?

    public weak var filterRangeView: FilterRangeViewRepresenter?
    public weak var pickerDelegate: RangeFiltersPickerDelegate?

    open var initialValues: FilterRangeValue {
        (initialFromValue ?? fromValue, initialToValue ?? toValue)
    }

    open var isChanged: Bool {
        initialFromValue != fromValue || initialToValue != toValue
    }

    public init(fromValue: CGFloat,
                toValue: CGFloat,
                stepValues: [CGFloat],
                initialFromValue: CGFloat? = nil,
                initialToValue: CGFloat? = nil) {

        self.fromValue = fromValue
        self.toValue = toValue
        self.stepValues = stepValues
        self.initialFromValue = initialFromValue
        self.initialToValue = initialToValue
    }

    open func rangeSliderValueIsChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureTextFields(with: values)
        pickerDelegate?.valuesIsChanging(values)
    }

    open func rangeSliderValueDidEndChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureTextFields(with: values)
        pickerDelegate?.valueDidEndChanging(values)
    }

    open func intervalInputValueIsChanging(_ values: FilterRangeValue, side: RangeBoundSide) {
        switch side {
        case .lower:
            filterRangeView?.configureRangeView(with: values)
            pickerDelegate?.valueDidEndChanging(values)

        case .upper:
            filterRangeView?.configureRangeView(with: values)
            pickerDelegate?.valueDidEndChanging(values)
        }
    }

    open func intervalInputValueDidEndChanging(_ values: FilterRangeValue, side: RangeBoundSide) {
        switch side {
        case .lower:
            filterRangeView?.configureRangeView(with: values)
            pickerDelegate?.valueDidEndChanging(values)

        case .upper:
            filterRangeView?.configureRangeView(with: values)
            pickerDelegate?.valueDidEndChanging(values)
        }
    }
}
