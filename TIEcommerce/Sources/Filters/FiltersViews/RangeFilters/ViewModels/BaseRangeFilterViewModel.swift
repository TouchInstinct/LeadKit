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

public typealias FilterRangeValue = (fromValue: Double, toValue: Double)

open class BaseRangeFilterViewModel: RangeFilterViewModelProtocol {

    public let fromValue: Double
    public let toValue: Double
    public let stepValues: [Double]

    public var initialFromValue: Double?
    public var initialToValue: Double?

    public weak var filterRangeView: FilterRangeViewRepresenter?
    public weak var pickerDelegate: RangeFiltersPickerDelegate?

    open var initialValues: FilterRangeValue {
        (initialFromValue ?? fromValue, initialToValue ?? toValue)
    }

    open var isChanged: Bool {
        initialFromValue != fromValue || initialToValue != toValue
    }

    public init(fromValue: Double,
                toValue: Double,
                stepValues: [Double],
                initialFromValue: Double? = nil,
                initialToValue: Double? = nil) {

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

    open func fromValueIsChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureRangeView(with: values)
        pickerDelegate?.valueDidEndChanging(values)
    }

    open func toValueIsChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureRangeView(with: values)
        pickerDelegate?.valueDidEndChanging(values)
    }

    open func fromValueDidEndChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureRangeView(with: values)
        pickerDelegate?.valueDidEndChanging(values)
    }

    open func toValueDidEndChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureRangeView(with: values)
        pickerDelegate?.valueDidEndChanging(values)
    }
}
