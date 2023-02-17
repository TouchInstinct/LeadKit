# LeadKit

LeadKit is the iOS framework with a bunch of tools for rapid app development.

This repository contains the following frameworks:

- [TISwiftUtils](TISwiftUtils) - a bunch of useful helpers for Swift development.
- [TIFoundationUtils](TIFoundationUtils) - set of helpers for Foundation framework classes.
- [TIUIKitCore](TIUIKitCore) - core ui elements and protocols from LeadKit.
- [TISwiftUICore](TISwiftUICore) Core UI elements: protocols, views and helpers.
- [TIUIElements](TIUIElements) - bunch of of useful protocols and views.
- [OTPSwiftView](OTPSwiftView) - a fully customizable OTP view.
- [TITableKitUtils](TITableKitUtils) - set of helpers for TableKit classes.
- [TIKeychainUtils](TIKeychainUtils) - set of helpers for Keychain classes.
- [TIPagination](TIPagination) - realisation of paginating items from a data source.
- [TINetworking](TINetworking) - Swagger-frendly networking layer helpers.
- [TIMoyaNetworking](TIMoyaNetworking) - Moya + Swagger network service.
- [TIAppleMapUtils](TIAppleMapUtils) - set of helpers for map objects clustering and interacting using Apple MapKit.
- [TIGoogleMapUtils](TIGoogleMapUtils) - set of helpers for map objects clustering and interacting using Google Maps SDK.
- [TIYandexMapUtils](TIYandexMapUtils) - set of helpers for map objects clustering and interacting using Yandex Maps SDK.
- [TIAuth](TIAuth) - login, registration, confirmation and other related actions

## Playgrounds

### Create new Playground

```sh
cd TIModuleName
nef plaground --name TIModuleName --cocoapods --custom-podfile PlaygroundPodfile
```
See example of `PlaygroundPodfile` in `TIFoundationUtils`


### Rename/add pages to Playground

For every new feature in module create new Playground page with documentation in comments. See [nef markdown documentation](https://github.com/bow-swift/nef#-generating-a-markdown-project).

### Create symlink to nef playground

```sh
cd TIModuleName
ln -s TIModuleName.app/Contents/MacOS/TIModuleName.playground TIModuleName.playground
```

### Add nef files to TIModuleName.app/.gitignore

```
# gitignore nef files
**/build/
**/nef/
LICENSE
```

### Add new playground to pre release script

`project-scripts/gen_docs_from_playgrounds.sh`:

```sh
PLAYGROUNDS="${SRCROOT}/TIFoundationUtils/TIFoundationUtils.app
${SRCROOT}/TIModuleName/TIModuleName.app"
```

### Exclude .app bundles from package sources

#### SPM

```swift
.target(name: "TIModuleName", dependencies: ..., path: ..., exclude: ["TIModuleName.app"]),
```

#### Podspec

```ruby
  sources = 'your_sources_expression'
  if File.basename(Dir.getwd) == s.name # installing using :path =>
    s.source_files = sources
    s.exclude_files = s.name + '.app'
  else
    s.source_files = s.name + '/' + sources
    s.exclude_files = s.name + '/*.app'
  end
```

## Docs:

- [TIFoundationUtils](docs/tifoundationutils)
  * [AsyncOperation](docs/tifoundationutils/asyncoperation.md)
- [Semantic Commit Messages](docs/semantic-commit-messages.md) - commit message codestyle.
- [Snippets](docs/snippets.md) - useful commands and scripts for development.

## Contributing

- Run following script in framework's folder:
```
./setup
```

- If legacy [Source](https://github.com/TouchInstinct/LeadKit/tree/master/Sources) folder needed, [build dependencies for LeadKit.xcodeproj](https://github.com/TouchInstinct/LeadKit/blob/master/docs/snippets.md#build-dependencies-for-LeadKit.xcodeproj).

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

## Legacy

Code located in root `Sources` folder and  `LeadKit.podspec` should be treated as legacy and shouldn't be used in newly created projects. Please use TI* modules via SPM or CocoaPods.
