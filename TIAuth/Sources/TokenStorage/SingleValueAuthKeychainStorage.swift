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
//

import TIFoundationUtils
import KeychainAccess
import Foundation

open class SingleValueAuthKeychainStorage<ValueType>: SingleValueStorage {
    open class Defaults {
        public static var keychainServiceIdentifier: String {
            Bundle.main.bundleIdentifier ?? "ru.touchin.TIAuth"
        }
    }

    public typealias GetValueClosure = (Keychain, String) -> Result<ValueType, StorageError>
    public typealias SetValueClosure = (Keychain, ValueType, String) -> Result<Void, StorageError>

    public let keychain: Keychain
    public let settingsStorage: AuthSettingsStorage
    public let storageKey: String
    public let getValueClosure: GetValueClosure
    public let setValueClosure: SetValueClosure

    public init(keychain: Keychain = Keychain(service: Defaults.keychainServiceIdentifier),
                settingsStorage: AuthSettingsStorage = DefaultAuthSettingsStorage(),
                storageKey: String,
                getValueClosure: @escaping GetValueClosure,
                setValueClosure: @escaping SetValueClosure) {

        self.keychain = keychain
        self.settingsStorage = settingsStorage
        self.storageKey = storageKey
        self.getValueClosure = getValueClosure
        self.setValueClosure = setValueClosure
    }

    // MARK: - SingleValueStorage

    open func hasStoredValue() -> Bool {
        !settingsStorage.shouldResetStoredAuthData && ((try? keychain.contains(storageKey)) ?? false)
    }

    open func store(value: ValueType) -> Result<Void, StorageError> {
        return setValueClosure(keychain, value, storageKey)
    }

    open func getValue() -> Result<ValueType, StorageError> {
        guard !settingsStorage.shouldResetStoredAuthData else {
            let result: Result<ValueType, StorageError>

            do {
                try keychain.remove(storageKey)
                settingsStorage.shouldResetStoredAuthData = false

                result = .failure(.valueNotFound)
            } catch {
                result = .failure(.unableToWriteData(underlyingError: error))
            }

            return result
        }

        return getValueClosure(keychain, storageKey)
    }
}
