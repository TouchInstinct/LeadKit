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
    var mirBundleId: String {
        Bundle.main.bundleIdentifier ?? .empty
    }
}

extension Keychain {
    static var mirKeychain: Keychain {
        .init(service: Bundle.main.mirBundleId)
    }
}

final class ViewModel {
    @KeychainCodableBackingStore(key: .userProfileKey, codableKeyValueStorage: .mirKeychain)

    private(set) var profile: UserProfile?
    
    func updateProfile(profile newProfile: UserProfile?) {
        let oldProfile = profile
    }
}
```

