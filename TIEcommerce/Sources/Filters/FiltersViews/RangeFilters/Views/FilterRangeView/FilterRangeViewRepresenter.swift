public protocol FilterRangeViewRepresenter: AnyObject {
    func configureTextFields(with value: FilterRangeValue)
    func configureRangeView(with value: FilterRangeValue)
}
