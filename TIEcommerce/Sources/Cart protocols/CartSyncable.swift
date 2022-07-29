import Foundation

///Содержит абстрактный метод, позволяющий получить на выходе итоговую локальную корзину. Должен поддерживать две стратегии работы:
///- замена локальной корзины серверной `func replace(localCart:, with:) -> CartModelProtocol`
///- слияние локальной корзины с серверной (детали слияния определяются в проекте) `func merge(localCart:, remoteCart:) -> CartModelProtocol`
protocol CartSyncable {
    /**
     Cлияние локальной корзины с серверной
     - Parameters:
        - localCart: `Cart` – локальная корзина
        - remoteCart: `Cart` – серверная корзина
     - Returns: `Cart` – совмещенная корзина
     */
    func merge(localCart: Cart,
               remoteCart: Cart) -> Cart
    /**
     Замена локальной корзины серверной
     - Parameters:
        - localCart: `Cart` – локальная корзина
        - remoteCart: `Cart` – серверная корзина
     - Returns: `Cart` – серверная корзина
     */
    func replace(localCart: Cart,
                 with remoteCart: Cart) -> Cart
}
