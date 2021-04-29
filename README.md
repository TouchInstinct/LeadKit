# LeadKit
LeadKit is the iOS framework with a bunch of tools for rapid app development.

## Additional

This repository contains the following additional frameworks:
- [TIUIKitCore](TIUIKitCore) - core ui elements and protocols from LeadKit.
- [TITransitions](TITransitions) - set of custom transitions to present controller.
- [TIUIElements](TIUIElements) - bunch of of useful protocols and views.
- [OTPSwiftView](OTPSwiftView) - a fully customizable OTP view.
- [TISwiftUtils](TISwiftUtils) - a bunch of useful helpers for development.
- [TITableKitUtils](TITableKitUtils) - Set of helpers for TableKit classes.
- [TIFoundationUtils](TIFoundationUtils) - Set of helpers for Foundation framework classes.
- [TIKeychainUtils](TIKeychainUtils) - Set of helpers for Keychain classes.
  
Useful docs:
- [Semantic Commit Messages](docs/semantic-commit-messages.md) - commit message codestyle.
- [Snippets](docs/snippets.md) - useful commands and scripts for development.

## Contributing

- Run following script in framework's folder:
```
./setup
```

- Make sure the commit message codestyle is followed. More about [Semantic Commit Messages](docs/semantic-commit-messages.md).

## Installation

### SPM

```swift
dependencies: [
    .package(url: "https://github.com/TouchInstinct/LeadKit.git", from: "x.y.z"),
],
```

### Cocoapods

```ruby
source 'https://github.com/TouchInstinct/Podspecs.git'

pod 'TISwiftUtils', 'x.y.z'
pod 'TIFoundationUtils', 'x.y.z'
# ...
```
