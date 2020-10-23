# TISwiftUtils

Bunch of useful helpers for development.

* [BackingStore](#backingstore)

## BackingStore

A property wrapper that wraps storage and defines getter and setter for accessing value from it.

### Example

```swift
final class ViewModel {
    @BackingStore(store: UserDefaults.standard,
                  getClosure: { $0.bool(forKey: "hasFinishedOnboarding") },
                  setClosure: { $0.set($1, forKey: "hasFinishedOnboarding") })
    var hasFinishedOnboarding: Bool
}
```
