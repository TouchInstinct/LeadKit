//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import RxSwift

public extension Single {

    /// Returns an single that invokes the specified factory function whenever a new observer subscribes.
    ///
    /// - Parameter elementFactory: Element factory function to invoke for each observer
    /// that subscribes to the resulting sequence.
    /// - Returns: An observable sequence whose observers trigger an invocation of the given element factory function.
    static func deferredJust(_ elementFactory: @escaping () throws -> Element) -> Single<Element> {
        return .create(subscribe: { (observer) -> Disposable in
            do {
                observer(.success(try elementFactory()))
            } catch {
                observer(.error(error))
            }

            return Disposables.create()
        })
    }
}
