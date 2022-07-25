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

import KeychainAccess
import Foundation
import LocalAuthentication

open class DefaultEncryptedTokenKeyStorage: SingleValueAuthKeychainStorage<Data> {
    open class Defaults: SingleValueAuthKeychainStorage<StringEncryptionResult>.Defaults {
        public static var encryptedTokenKeyStorageKey: String {
            keychainServiceIdentifier + ".encryptedTokenKey"
        }

        public static var reusableLAContext: LAContext {
            let context = LAContext()
            context.touchIDAuthenticationAllowableReuseDuration = LATouchIDAuthenticationMaximumAllowableReuseDuration
            return context
        }
    }

    public init(keychain: Keychain = Keychain(service: Defaults.keychainServiceIdentifier),
                localAuthContext: LAContext = Defaults.reusableLAContext,
                settingsStorage: AuthSettingsStorage = DefaultAuthSettingsStorage(),
                encryptedTokenKeyStorageKey: String = Defaults.encryptedTokenKeyStorageKey) {

        let getValueClosure: GetValueClosure = { keychain, storageKey in
            do {
                guard let value = try keychain.getData(storageKey) else {
                    return .failure(.valueNotFound)
                }

                return .success(value)
            } catch {
                return .failure(.unableToExtractData(underlyingError: error))
            }
        }

        let setValueClosure: SetValueClosure = { keychain, value, storageKey in
            do {
                return .success(try keychain.set(value, key: storageKey))
            } catch {
                return .failure(.unableToWriteData(underlyingError: error))
            }
        }

        super.init(keychain: keychain.authenticationContext(localAuthContext),
                   settingsStorage: settingsStorage,
                   storageKey: encryptedTokenKeyStorageKey,
                   getValueClosure: getValueClosure,
                   setValueClosure: setValueClosure)
    }
}
