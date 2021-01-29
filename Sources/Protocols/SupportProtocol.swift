//
//  Copyright (c) 2017 Touch Instinct
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

import Foundation

/**
 Use `Support` proxy as customization point for constrained protocol extensions.

 General pattern would be:

 // 1. Extend Support protocol with constrain on Base
 // Read as: Support Extension where Base is a SomeType
 extension Support where Base: SomeType {
 // 2. Put any specific reactive extension for SomeType here
 }

 With this approach we can have more specialized methods and properties using
 `Base` and not just specialized on common base type.

 */
public struct Support<Base> {
    /// Base object to extend.
    public let base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has support extensions.
public protocol SupportCompatible {
    /// Extended type
    associatedtype CompatibleType

    /// Support extensions.
    static var support: Support<CompatibleType>.Type { get set }

    /// Support extensions.
    var support: Support<CompatibleType> { get set }
}

public extension SupportCompatible {
    /// Support extensions.
    static var support: Support<Self>.Type {
        get {
            Support<Self>.self
        }
        set { // swiftlint:disable:this unused_setter_value
            // this enables using Support to "mutate" base type
        }
    }

    /// Support extensions.
    var support: Support<Self> {
        get {
            Support(self)
        }
        set { // swiftlint:disable:this unused_setter_value
            // this enables using Support to "mutate" base object
        }
    }
}

extension NSObject: SupportCompatible {}
