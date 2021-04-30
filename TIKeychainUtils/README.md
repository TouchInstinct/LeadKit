# TIKeychainUtils

Set of helpers for Keychain classes.
Bunch of CodableBackingStore from TIFoundationUtils and KeychainAccess.
Implement 

#### @propertyWrapper example

```swift
extension StorageKey {
    static var userProfileKey: StorageKey<UserProfile> {
        .init(rawValue: "userProfileKey")
    }
}

extension Bundle {
    var bundleId: String {
        Bundle.main.bundleIdentifier ?? .empty
    }
}

extension Keychain {
    static var defaultKeychain: Keychain {
        .init(service: Bundle.main.bundleId)
    }
}

final class ViewModel {
    @KeychainCodableBackingStore(key: .userProfileKey, codableKeyValueStorage: .defaultKeychain)

    private(set) var profile: UserProfile?
    
    func updateProfile(newProfile: UserProfile?) {
        profile = newProfile
    }
}
```

