import Foundation

protocol CartProductPrice {
    ///Стоимость
    var value: Int { get }
    ///Трехсимвольный код валюты в ISO 4217
    var currencyCode: String { get }
}
