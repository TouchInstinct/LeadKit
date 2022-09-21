public protocol RangeFilterDelegate: AnyObject {
    func valuesIsChanging(_ value: FilterRangeValue)
    func valueDidEndChanging(_ value: FilterRangeValue)
}
