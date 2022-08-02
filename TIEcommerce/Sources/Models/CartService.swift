//
//  Copyright (c) 2022 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import TIFoundationUtils
import TISwiftUtils

public protocol CartService {
    associatedtype CartType: Cart
    associatedtype CartProductType: CartProduct
    
    var localCart: CartType? { get }
    var removedProducts: [CartProductType] { get }
    var notAvailableProducts: [CartProductType] { get }
    ///Примененные бонусы
    var appliedBonuses: Int? { get }
    
    //MARK: - Work with products
    func updateCountInCart(for product: CartProductType, count: Int)
    func updateCountInCart(for productId: String, count: Int)
    
    ///Возможность вернуть товар в корзину
    func recoverProductBy(id: String)
    
    //MARK: - Work with promocodes
    ///Применить  промокод
    func applyPromocode(_ promocode: String,
                        successCompletion: ParameterClosure<CartType>?,
                        failureCompletion: ParameterClosure<BaseErrorResponseBody>?)
    ///Удалить примененный промокод
    func removePromocode(_ promocode: String,
                         successCompletion: ParameterClosure<CartType>?,
                         failureCompletion: ParameterClosure<BaseErrorResponseBody>?)
    
    //MARK: - Network
    func loadRemoteCart(successCompletion: ParameterClosure<CartType>?,
                        failureCompletion: ParameterClosure<BaseErrorResponseBody>?)
    
    //MARK: - Work with local cart
    /**
     Cлияние локальной корзины с серверной
     - Parameters:
        - remoteCart: `Cart` – серверная корзина
     - Returns: `Cart` – совмещенная корзина
     */
    func mergeLocalCart(with remoteCart: CartType) -> CartType
    /**
     Замена локальной корзины серверной
     - Parameters:
        - remoteCart: `Cart` – серверная корзина
     - Returns: `Cart` – серверная корзина
     */
    func replaceLocalCart(with remoteCart: CartType) -> CartType
    
    //MARK: - Subscribe on changes
    ///Подписаться на изменение корзины
    func subscribeOnCartChanging(completion: ParameterClosure<CartType>) -> Cancellable
    ///Подписаться на изменение продукта по ID
    func subscribeOnProductChanging(productId: String, completion:  ParameterClosure<CartProductType>) -> Cancellable
}
