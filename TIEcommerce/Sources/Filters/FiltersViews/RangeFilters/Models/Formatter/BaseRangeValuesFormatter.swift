import Foundation

open class BaseRangeValuesFormatter: RangeValuesFormatterProtocol {

    open var formatter: NumberFormatter {
        let formatter = NumberFormatter()

        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        return formatter
    }

    public init() { }

    open func string(fromDouble value: Double) -> String {
        let nsNumber = NSNumber(floatLiteral: value)

        return formatter.string(from: nsNumber) ?? ""
    }

    open func double(fromString value: String) -> Double {
        formatter.number(from: value)?.doubleValue ?? 0
    }
}