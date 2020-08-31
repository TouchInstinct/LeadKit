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

@propertyWrapper public struct BackingStore<Store, StoreContent> {

    public typealias InitClosure = (StoreContent) -> Store
    public typealias GetClosure = (Store) -> StoreContent
    public typealias SetClosure = (Store, StoreContent) -> Void

    private let getClosure: GetClosure
    private let setClosure: SetClosure

    private let store: Store

    public init(wrappedValue: StoreContent,
                storageInitClosure: InitClosure,
                getClosure: @escaping GetClosure,
                setClosure: @escaping SetClosure) {

        self.store = storageInitClosure(wrappedValue)
        self.getClosure = getClosure
        self.setClosure = setClosure
    }

    public init(store: Store,
                getClosure: @escaping GetClosure,
                setClosure: @escaping SetClosure) {

        self.store = store
        self.getClosure = getClosure
        self.setClosure = setClosure
    }

    public var wrappedValue: StoreContent {
        get {
            getClosure(store)
        }
        set {
            setClosure(store, newValue)
        }
    }

    public var projectedValue: Store {
        store
    }
}
