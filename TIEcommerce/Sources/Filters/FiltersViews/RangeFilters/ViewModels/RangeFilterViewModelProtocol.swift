public protocol RangeFilterViewModelProtocol {
    
    var fromValue: Double { get }
    var toValue: Double { get }
    var stepValues: [Double] { get }
    var initialFromValue: Double? { get }
    var initialToValue: Double? { get }

    func rangeSliderValueIsChanging(_ values: FilterRangeValue)
    func rangeSliderValueDidEndChanging(_ values: FilterRangeValue)

    func toValueIsChanging(_ values: FilterRangeValue)
    func toValueDidEndChanging(_ values: FilterRangeValue)

    func fromValueDidEndChanging(_ values: FilterRangeValue)
    func fromValueIsChanging(_ values: FilterRangeValue)
}
