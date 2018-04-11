# Changelog

### 0.7.7
- **Remove**: `App`, `Log` and `LogFormatter`.
- **Remove**: `CocoaLumberjack` dependency.
- **Add**: Rotate operation for image drawing.
- **Add**: `mapViewEvents` overload with closure that returns array of disposables. 
- **Update**: Update `ObjectMapper` to 3.1.

### 0.7.6

- **Add**: `NetworkServiceConfiguration` to configure NetworkService instance
- **Remove**: `ConfigurableNetworkSevice` protocol
- **Update**: Acceptable status codes in SessionManager become `Set<Int>`

### 0.7.5
- **Add**: `topConfiguration` and `bottomConfiguration` properties, methods to configure top and bottom separators in `CellSeparatorType` extension.
- **Add**: `totalHeight` property in `SeparatorConfiguration` extension.

### 0.7.4
- **Update**: Exclude UIApplication extensions from iOS-Extension subspec.

### 0.7.3
- **Update**: Xcode 9.3 migration.
- **Remove**: Default initializer for Network service that conforms to `ConfigurableNetworkService` protocol.
- **[Breaking Change]**: `DateFormattingService` class replaced with protocol.
- **Add**: `SwiftDate` dependency for `DateFormattingService`.
- **Add**: `ViewBackground` enum that describes possible view backgrounds.
- **Add**: `ViewText` enum that describes text with appearance options.
- **Removed**: `String+SizeCalculation` extension.

### 0.7.2

- **Fixed**: Change root controller for window

### 0.7.1
- **Add**: Extension for comparing optional arrays (`[T]?`) with `Equatable` elements.
- **Add**: `additionalHttpHeaders` static field in `ConfigurableNetworkService` protocol.
- **Add**: Default initializer for Network service that conforms to `ConfigurableNetworkService` protocol.

## 0.7.0
- **Add**: `TotalCountCursor` for total count based pagination and related stuff.
- **[Breaking Change]**: `PaginationTableViewWrapper` and `PaginationTableViewWrapperDelegate` was renamed to `PaginationWrapper` and `PaginationWrapperDelegate `. Also there is significant changes in api
- **Add**: `GeneralDataLoadingModel` and `PaginationDataLoadingModel` for regular and paginated data loading with state handling.
- **Add**: `GeneralDataLoadingViewModel` and `GeneralDataLoadingController` for regular data loading and state handling in UI.
- **Add**: `ConfigurableNetworkService` - replacement of `DefaultNetworkService` from LeadKitAdditions.
- **Add**: `NumberFormattingService` and `NumberFormat` protocols with default implementation for creating per-project number formatters.
- **Add**: Very flexible in configuration `TextFieldViewModel` with build-in two-side data model binding.
- **Add**: `SingleLoadCursorConfiguration` as a replacement of `SingleLoadCursor`.
- **Add**: `UIApplication` extensions for making phone calls.
- **Add**: `NSAttributedString` extensions for appending attributed strings using `+` operator.
- **Change**: Lots of fixes and enhancements.
- **Update**: Update dependecies versions.

### 0.6.7

- **Add**: UITableView extension to add colored background for tableview bounce area.

### 0.6.6

- **Add**: Ability to map primitive response types (`String`, `Int`, `[String]`, etc.).

### 0.6.5

- **Add**: Ability to handle responses with non-default status codes.

### 0.6.4

- **Fix**: SpinnerView bug(no animation) in Swift 4.

### 0.6.3
- **Fix**: SeparatorCell updates constraints after setting separator insets

### 0.6.2
- **Fix**: AlamofireManager extension no longer performs requests with default manager

### 0.6.1
- **New**: `RequestError`. Represents general api request errors
- **Change**: All api methods now throws `RequestError` when fails.

## 0.6.0
- **New**: Swift 4 support & dependencies update.
- **Remove**: `Mutex`
- **Remove**: `IndexPath+ImmutableIndexPath`
- **Remove**: `StoryboardProtocol`, `StoryboardProtocol+Extensions`, `StoryboardProtocol+DefaultBundle`
- **Remove**: `String+Extensions` image property
- **Remove**: `UICollectionView+CellRegistration`
- **Remove**: `UIStoryboard+InstantiateViewController`
- **Remove**: `NetworkService` extension for loading images
- **Remove**: `Observable` creation for `ImmutableMappable`
- **Remove**: `UIView` and `UsedDefaults` extensions, `EstimatedViewHeightProtocol`, `StaticEstimatedViewHeightProtocol`, `StoryboardIdentifierProtocol`

### 0.5.18
- **Fix**: EmptyCell first appearance setup fix

### 0.5.17
- **Fix**: EmptyCell reusing appearance fix
- **Fix**: SeparatorCell reusing separators fix

### 0.5.16

- **Change**: Rename `AppearanceProtocol` to `AppearanceConfigurable`
- **Add**: `subscript(safe:)` subscript to `Array` extension for safe access to element by index

### 0.5.15

- **Add**: `AppearanceProtocol` which ensures that specific type can apply appearance to itself
- **Add**: `with(appearance:)`,  `set(appearance:)`  methods to TableRow extension
- **Add**: `Appearance` to `EmptyCell`
- **Remove**: `SeparatorCellViewModel`.

### 0.5.13

- **Change**: Remove type erasure behavior from `AnyBaseTableRow`
- **Change**: Rename `AnyBaseTableRow` class to `SeparatorRowBox`
- **Change**: Move `anyRow` property from `EmptyCellRow` to `TableRow` extension and rename it to `separatorRowBox`.
- **Change**: Move `configure(extreme: middle:)` method from `TableDirector` extension to `Array` extension and rename it to `configureSeparators(extreme: middle:)`

### 0.5.12

- **Fix**: Update type of `viewModel` in `ConfigurableController` to `ImplicitlyUwrappedOptional<ViewModelT>` instead of `ViewModelT`

### 0.5.11

- **[Breaking Change]**: rename initializer from `init(initialFrom:)` to `init(resetFrom:)` in `ResettableType`
- **Add**: `SeparatorCell` with `SeparatorCellViewModel`
- **Add**: `AnyBaseTableRow` for type-erasure
- **Add**: `EmptyCellRow` for empty cell with static height

### 0.5.10

- **Fix**: `Public` modifier for `SpinnerView`

### 0.5.9

- **Fix**: One-two-many fixed for values more than 99

### 0.5.8

- **Fix**: Synchronization over `NSRecursiveLock` for request count tracker in NetworkService

### 0.5.7

- **Add**: String extension `localizedComponent(value:stringOne:stringTwo:stringMany:)`

### 0.5.6

- **Fix**: Clear tableview if placeholder is shown



