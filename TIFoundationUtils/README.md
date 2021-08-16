# TIFoundationUtils

Set of helpers for Foundation framework classes.

* [TITimer](/TITimer) - pretty timer
* [CodableKeyValueStorage](#codablekeyvaluestorage)

## CodableKeyValueStorage

Storage that can get and set codable objects by the key.

Implementations: `UserDefaults`

### Example

```swift
struct ProfileInfo: Codable {
    let userName: String
}
```

Keys:

```swift
extension StorageKey {
    static var profileKey: StorageKey<ProfileInfo> {
        .init(rawValue: "profileKey")
    }

    static var onboardingFinishedKey: StorageKey<Bool> {
        .init(rawValue: "onboardingFinishedKey")
    }
}
```

#### Subscript example

```swift
var defaults = UserDefaults.standard
defaults[.profileKey] = ProfileInfo(userName: "John Appleseed")
defaults[.profileKey] = "Agent Smith" // this will threat compile error:
// Cannot assign value of type 'String' to subscript of type 'ProfileInfo'
```
#### @propertyWrapper example

```swift
final class ViewModel {
    @UserDefaultsCodableBackingStore(key: .profileKey, codableKeyValueStorage: .standard)
    var profile: ProfileInfo?

    // This will threat compile error:
    // Cannot convert value of type 'BackingStore<UserDefaults, Bool?>' to specified type 'ProfileInfo?'
    @UserDefaultsCodableBackingStore(key: .onboardingFinishedKey, codableKeyValueStorage: .standard)
    var wrongKeyProfile: ProfileInfo?

    // For primitive types we can't use default json decoder/encoder
    @UserDefaultsCodableBackingStore(key: .onboardingFinishedKey,
                                     codableKeyValueStorage: .standard,
                                     decoder: UnarchiverKeyValueDecoder(),
                                     encoder: ArchiverKeyValueEncoder())
    var onboardingFinished = false
}
```
