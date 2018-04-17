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

import ObjectMapper

extension Int: UniversalMappable {}
extension Int8: UniversalMappable {}
extension Int16: UniversalMappable {}
extension Int32: UniversalMappable {}
extension Int64: UniversalMappable {}

extension UInt: UniversalMappable {}
extension UInt8: UniversalMappable {}
extension UInt16: UniversalMappable {}
extension UInt32: UniversalMappable {}
extension UInt64: UniversalMappable {}

extension Float: UniversalMappable {}       // aka float32
extension Float64: UniversalMappable {}     // aka double

public extension BinaryInteger where Self: UniversalMappable {

    static func decode(from map: Map, key: String) throws -> Self {
        return try map.value(key)
    }

}

public extension BinaryFloatingPoint where Self: UniversalMappable {

    static func decode(from map: Map, key: String) throws -> Self {
        return try map.value(key)
    }

}

extension Bool: UniversalMappable {

    public static func decode(from map: Map, key: String) throws -> Bool {
        return try map.value(key)
    }

}

extension String: UniversalMappable {

    public static func decode(from map: Map, key: String) throws -> String {
        return try map.value(key)
    }

}
