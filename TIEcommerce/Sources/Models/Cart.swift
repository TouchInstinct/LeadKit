import Foundation

protocol Cart {
    ///Продукты в корзине пользователя
    var products: [CartProduct] { get }
    ///Применённые промокоды
    var promocodes: [String] { get }
    ///Количество доступных бонусов для использования
    var availableBonuses: Int? { get }
}
