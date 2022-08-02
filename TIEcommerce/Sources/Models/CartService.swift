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
    var promocodes: [Promocode] { get }
    
    func updateCountInCart(for product: CartProductType, count: Int)
    func updateCountInCart(for productId: Int, count: Int)
    
    func loadRemoteCart(successCompletion: ParameterClosure<CartType>?,
                        failureCompletion: ParameterClosure<BaseErrorResponseBody>?)
    /**
     Cлияние локальной корзины с серверной
     - Parameters:
        - localCart: `Cart` – локальная корзина
        - remoteCart: `Cart` – серверная корзина
     - Returns: `Cart` – совмещенная корзина
     */
    func merge(localCart: CartType,
               remoteCart: CartType) -> CartType
    /**
     Замена локальной корзины серверной
     - Parameters:
        - localCart: `Cart` – локальная корзина
        - remoteCart: `Cart` – серверная корзина
     - Returns: `Cart` – серверная корзина
     */
    func replace(localCart: CartType,
                 with remoteCart: CartType) -> CartType
    
    func subscribeOnCartChanging(completion: ParameterClosure<CartType>) -> Cancellable
    func subscribeOnProductChanging(productId: Int, completion:  ParameterClosure<CartProductType>) -> Cancellable
}
