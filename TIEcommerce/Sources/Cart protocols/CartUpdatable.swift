import Foundation

///Содержит абстрактный метод, позволяющий отправить локальную корзину полностью и получить в ответ серверную корзину
protocol CartUpdatable {
    ///Отправляем локальную корзину полностью и получаем в ответ серверную корзину или ошибку
    func loadRemoteCart(from localCart: Cart,
                        successCompletion: ParameterClosure<Cart>?,
                        failureCompletion: ParameterClosure<BaseErrorResponseBody>?)
}
