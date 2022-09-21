public protocol RangeValuesFormatterProtocol {
    func string(fromDouble value: Double) -> String
    func double(fromString value: String) -> Double
}
