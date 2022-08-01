import Foundation

protocol CartProduct {
    ///Идентификатор продукта
    var id: String { get }
    ///Цена в определённой валюте
    var price: Price { get }
    ///Сколько единиц есть доступно
    var availableCount: Int? { get }
    ///Варианты товара (фасовка, цвет, размер, и т.п.)
    var variants: [CartProduct] { get }
    ///Количество бонусов, которые будут начислены при покупке
    var bonuses: Int? { get }
}
