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

import Foundation
import KeychainAccess

open class DefaultEncryptedTokenStorage: SingleValueAuthKeychainStorage<StringEncryptionResult> {
    open class Defaults: SingleValueAuthKeychainStorage<StringEncryptionResult>.Defaults {
        public static var encryptedTokenStorageKey: String {
            keychainServiceIdentifier + ".encryptedToken"
        }
    }

    public init(keychain: Keychain = Keychain(service: Defaults.keychainServiceIdentifier),
                settingsStorage: AuthSettingsStorage = DefaultAuthSettingsStorage(),
                encryptedTokenStorageKey: String = Defaults.encryptedTokenStorageKey) {

        let getValueClosure: GetValueClosure = { keychain, storageKey in
            do {
                guard let value = try keychain.getData(storageKey) else {
                    return .failure(.valueNotFound)
                }

                do {
                    return .success(try StringEncryptionResult(storableData: value))
                } catch {
                    return .failure(.unableToDecode(underlyingError: error))
                }
            } catch {
                return .failure(.unableToExtractData(underlyingError: error))
            }
        }

        let setValueClosure: SetValueClosure = { keychain, value, storageKey in
            do {
                return .success(try keychain.set(value.asStorableData(), key: storageKey))
            } catch {
                return .failure(.unableToWriteData(underlyingError: error))
            }
        }

        super.init(keychain: keychain,
                   settingsStorage: settingsStorage,
                   storageKey: encryptedTokenStorageKey,
                   getValueClosure: getValueClosure,
                   setValueClosure: setValueClosure)
    }
}
