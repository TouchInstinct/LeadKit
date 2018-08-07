//
//  Copyright (c) 2018 Touch Instinct
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
//

import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait {

    /// Replaces emitted element with new one.
    ///
    /// - Parameter value: A new element.
    /// - Returns: An primitive sequence whose element is equal to passed value.
    func replace<T>(with value: T) -> PrimitiveSequence<Trait, T> {
        return map { _ in value }
    }

    /// Replaces emitted element with Void.
    ///
    /// - Returns: An primitive sequence whose element is equal to Void.
    func asVoid() -> PrimitiveSequence<Trait, Void> {
        return replace(with: Void())
    }

    /// Cast emitted element to optional type.
    ///
    /// - Returns: An primitive sequence whose element is equals to optional type of element.
    func asOptional() -> PrimitiveSequence<Trait, Element?> {
        return map { $0 }
    }

}
