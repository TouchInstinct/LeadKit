# Changelog

### 0.8.4

- **Fix**: Add `SeparatorCell` to `Core-iOS-Extension`. 
Fix `UIApplication` extensions path for `Core-iOS-Extension` exclusions.

### 0.8.3

- **Fix**: `SpinnerView` animation freezing

### 0.8.2

- **Add**: `acceptableStatusCodes` property to `NetworkServiceConfiguration`

### 0.8.1

- **Add**: Support for `localizedComponent` for `FixedWidthInteger`


### 0.8.0
- **Add**: tests for `NetworkService`
- **Add**: `toJSON(with encoder: JSONEncoder)` method to `Encodable`
- **Add**: `failedToDecode` error case to `LeadKitError`
- **Add**: `SessionManager` class
- **Remove**: occurrences `ObjectMapper` pod and its occurrences in code
- **Update**: replace `ObjectMapper` mapping with `Decodable`

### 0.7.19
- **Fix**: `PaginationWrapper` retry button showing.

### 0.7.18
- **Update**: default implementation of `PaginationWrapperUIDelegate`.

### 0.7.17
- **Add**: `RxNetworkOperationModel` base class, `NetworkOperationState` and `NetworkOperationStateType` protocols.

### 0.7.16
- **[Breaking Change]**: Remove `ModuleConfigurator`, change type of `ConfigurableController.viewModel` property from `IUO` to plain `ViewModelT`.
- **Add**: `InitializableView` protocol with default implementation.
- **Update**: `ConfigurableController` protocol now inherit `InitializableView`.
- **[Breaking Change]**: `setAppearance` of `ConfigurableController` replaced with `configureAppearance` of `InitializableView`.

### 0.7.15
- **Fix**: `Double.roundValue(withPrecision:)` rounding issue
- **Add**: `Double+Rounding` test case

### 0.7.14
- **[Breaking Change]**: `PaginationWrapper` separating state views from data loading.

### 0.7.13
- **Update**: Migrate from `Variable` to `BehaviorRelay`.
- **Fix**: `PaginationWrapper` retry load more after fail.
- **Fix**: `safeClear` method of `TableDirector` now creates section without header and footer.
- **Add**: `TableSection` convenience initializer for section without footer and header.

### 0.7.12
- **Add**: `UniversalMappable` protocol to have ability generate generic mapping models

### 0.7.11
- **Fix**: `addHeaderBackground` cells overlapping.

### 0.7.10
- **Fix**: `wtihInsets` renamed to `with insets`

### 0.7.9
- **Fix**: timeoutInterval is set to another URLSessionConfiguration property in NetworkServiceConfiguration

### 0.7.8
- **Remove**: `App`, `Log` and `LogFormatter`.
- **Remove**: `CocoaLumberjack` dependency.
- **Add**: Rotate operation for image drawing.
- **Add**: `mapViewEvents` overload with closure that returns array of disposables.
- **Update**: Update `ObjectMapper` to 3.1.
- **Add**: `apiRequestParameters` method to `NetworkServiceConfiguration` extension.
- **Update**: Rename setToCenter(withInsets:) to pintToSuperview(withInsets:excluding:)
- **Update**: Added parameter "edges" with label "excluding" to aforementioned method

### 0.7.7
- **Fix**: Fix doubling separator line issue

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
