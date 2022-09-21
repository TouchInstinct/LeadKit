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
    public weak var delegate: RangeFilterDelegate?

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
        delegate?.valuesIsChanging(values)
    }

    open func rangeSliderValueDidEndChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureTextFields(with: values)
        delegate?.valueDidEndChanging(values)
    }

    open func fromValueIsChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureRangeView(with: values)
        delegate?.valueDidEndChanging(values)
    }

    open func toValueIsChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureRangeView(with: values)
        delegate?.valueDidEndChanging(values)
    }

    open func fromValueDidEndChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureRangeView(with: values)
        delegate?.valueDidEndChanging(values)
    }

    open func toValueDidEndChanging(_ values: FilterRangeValue) {
        filterRangeView?.configureRangeView(with: values)
        delegate?.valueDidEndChanging(values)
    }
}
