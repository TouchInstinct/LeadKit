//
//  Copyright (c) 2020 Touch Instinct
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

import TISwiftUtils

public typealias CodableKeyValueBackingStore<S: CodableKeyValueStorage, T: Codable> = BackingStore<S, T>

public extension BackingStore where Store: CodableKeyValueStorage, StoreContent: Codable {
    init<Value: Codable>(key: StorageKey<Value>,
                         codableKeyValueStorage: Store,
                         decoder: CodableKeyValueDecoder = JSONKeyValueDecoder(),
                         encoder: CodableKeyValueEncoder = JSONKeyValueEncoder())
        where StoreContent == Value? {

        self.init(store: codableKeyValueStorage,
                  getClosure: { try? $0.codableObject(forKey: key, decoder: decoder) },
                  setClosure: { try? $0.setOrRemove(codableObject: $1, forKey: key, encoder: encoder) })
    }

    init(wrappedValue: StoreContent,
         key: StorageKey<StoreContent>,
         codableKeyValueStorage: Store,
         decoder: CodableKeyValueDecoder = JSONKeyValueDecoder(),
         encoder: CodableKeyValueEncoder = JSONKeyValueEncoder()) {

        self.init(store: codableKeyValueStorage,
                  getClosure: { $0.codableObject(forKey: key, defaultValue: wrappedValue, decoder: decoder) },
                  setClosure: { try? $0.setOrRemove(codableObject: $1, forKey: key, encoder: encoder) })
    }
}
