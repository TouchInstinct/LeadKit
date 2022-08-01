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

protocol CartPublisher {
    func subscribeOnCartChanging(completion: ParameterClosure<Cart>)) -> Cancellable
    func subscribeOnProductChanging(productId: Int, completion:  ParameterClosure<CartProduct>) -> Cancellable
}

open class CartService: RemovableProductCart, NotAvailableProductsHolder, PromocodesHolder {
    open private(set) var localCart: Cart?
    open private(set) var removedProducts: [CartProduct]
    open private(set) var notAvailableProducts: [CartProduct]
    open private(set) var promocodes: [Promocode]
    
    open func updateCountInCart(for product: CartProduct, count: Int) { }
    open func updateCountInCart(for productId: Int, count: Int) { }
}
