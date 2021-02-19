//
//  Copyright (c) 2021 Touch Instinct
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

public typealias UserDefaultsBackingStore<T> = BackingStore<UserDefaults, T>

public extension BackingStore where Store: UserDefaults {
    typealias GetValueByRawKeyClosure = (Store, String) -> StoreContent
    typealias SetValueByRawKeyClosure = (Store, StoreContent, String) -> Void

    init<Value>(key: StorageKey<Value>,
                userDefaultsStorage: Store,
                getClosure: @escaping GetValueByRawKeyClosure,
                setClosure: @escaping SetValueByRawKeyClosure)
        where StoreContent == Value? {

        self.init(store: userDefaultsStorage,
                  getClosure: {
                    guard $0.object(forKey: key.rawValue) != nil else {
                        return nil
                    }

                    return getClosure($0, key.rawValue)
                  },
                  setClosure: {
                    setClosure($0, $1, key.rawValue)
                  })
    }

    init(wrappedValue: StoreContent,
         key: StorageKey<StoreContent>,
         userDefaultsStorage: Store,
         getClosure: @escaping GetValueByRawKeyClosure,
         setClosure: @escaping SetValueByRawKeyClosure) {

        self.init(store: userDefaultsStorage,
                  getClosure: {
                    guard $0.object(forKey: key.rawValue) != nil else {
                        return wrappedValue
                    }

                    return getClosure($0, key.rawValue)
                  },
                  setClosure: {
                    setClosure($0, $1, key.rawValue)
                  })
    }
}
