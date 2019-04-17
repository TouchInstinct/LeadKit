# Changelog

### 0.9.16
- **Add**: `LabelTableViewCell` moved from `LeadKitAdditions`.
- **Add**: `SnapKit` dependency.

### 0.9.15
- **Add**: `BaseSearchViewController` class that allows to enter text for search and then displays search results in table view.
- **Add**: `BaseSearchViewModel` class that loads data from a given data source and performs search among the results.
- **Add**: `SearchResultsController` protocol that represent a controller able to display search results.
- **Add**: `SearchResultsControllerState` enum that represents `SearchResultsController` state.

### 0.9.14
- **Update**: SwiftDate dependency (~> 6).

### 0.9.13
- **Add**: `ApiUploadRequestParameters` struct that defines upload data request parameters.
- **Add**: `rxUploadRequest` method to `NetworkService` class that performs reactive request to upload data.
- **Add**: `uploadResponseModel` method to `SessionManager` extension that executes upload request and serializes response.
- **Add**: `handleMappingError` method to `Error` extension that tries to serialize response from a mapping request error to a model.
- **Add**: `handleMappingError` method to `ObservableType`, `Single`, `Completable` extensions that handles a mapping error and serialize response to a model.
- **Add**: `validate` method to `DataRequest` observable extension that validates status codes and catch network errors.
- **Add**: `dataApiResponse` method to `DataRequest` reactive extension that serializes response into data.
- **Update**: `validStatusCodes` parameter in network methods renamed to `additionalValidStatusCodes`.

### 0.9.12
- **Update**: Swift 5 support

### 0.9.11
- **[Breaking change]**: Renamed `NumberFormat`'s `allOptions` to `allCases`
- **Fix**: Closure syntax fix. New closure naming.
- **Fix**: Added missing `BasePlaceholderView` protocol function.

### 0.9.10
- **Remove**: Removed unused scheme & target
- **Remove**: Cocoapods deintegrated
- **Update**: New closure typealiases

### 0.9.9
- **Add**: `validStatusCodes` parameter to request methods in `NetworkService` class, that expands valid status codes for request.
- **Add**:  `validStatusCodes` parameter to response methods in `SessionManager` extension, that expands valid status codes for request.

### 0.9.8
- **Add**: `rxDataRequest` method to `NetworkService` class, that performs reactive request to get data and http response.
- **Add**: `responseData` method to `SessionManager` extension, that executes request and returns data.

### 0.9.7
- **Add**: Carthage support.

### 0.9.6
- **Add**:  Add new `configureSeparators` method to `SeparatorRowBox` array.

### 0.9.5
- **Add**:  `TitleType` enum, that defines `UIViewController`'s title type.
- **Add**: `UINavigationItem.largeTitleDisplayMode` property, that defines  `UINavigationItem`'s large title display mode.
- **Add**: `UIViewController.updateNavigationItemTitle` method, that takes `TitleType` as a parameter and updates `UIViewController`'s title.

### 0.9.4
- **Add**:  initialization of `ApiRequestParameters`, that takes an array as a request parameter.
- **Add**: `NetworkServiceConfiguration.apiRequestParameters` method, that creates `ApiRequestParameters` with array request parameter.
- **Add**: `SessionManager.request` method, that takes an array as a request parameter.
- **Add**: `RequestUsageError` error, that represents wrong usage of requset parameters.

### 0.9.3
- **Add**: `Insert`/`Remove` section with animation functions to `TableKit`. Also make new function `Replace` that uses new `Insert`/`Remove` to animate section replace.

### 0.9.2
- **Update**: Add response to `RequestError`.
- **Fix**:  Update `SessionManager+Extensions` to catch network connection error.

### 0.9.1
- **Update**: `DataRequest+Extensions` time out as network error

### 0.9.0
- **Update**: version update.

### 0.8.13
- **Add**: `configureLayout` method to `InitializeableView` protocol and all implementations.
- **Update**: `GeneralDataLoadingViewModel` now can handle state changes and result of data source. Previously it was possible only in view controller.
- **Add**: `GeneralDataLoadingHandler` protocol, that defines methods for common data loading states handling.
- **Add**: `resultObservable` and `resultDriver` properties to `GeneralDataLoadingViewModel`.
- **Add**: `hidesWhenStopped` option to `SpinnerView`, so you can stop animation without hiding image inside it.
- **Update**: Migrate to Swift 4.2 & Xcode 10. Update dependencies.

### 0.8.12
- **Add**: `UserDefaults+Codable` is back. Now with generic subscript support.

### 0.8.11
- **Change**: `NumberFormattingService.computedFormatters` computed var reverted to static.

### 0.8.10
- **[Breaking change]**: `NumberFormattingService` methods is not static anymore.
- **Add**: `NSNumberConvertible` protocol for `NumberFormattingService` use cases.
- **Add**: `TableDirector` methods for rows insertion and removal without reload a whole table.
- **Add**: `UIImageView` binder for disclosure indicator rotation.
- **Add**: `UIView.addSubviews(:)` methods with variable number of arguments and array of views.
- **Add**: `PlaceholderConfigurable` that defines attributes and methods for view with placeholder and regular state.
- **Add**: `ContentLoadingViewModel` enum that describes possible `PlaceholderConfigurable` view states.

### 0.8.9
- **Add**: Methods `replace(with:)`, `asVoid()`, `asOptional()` to `ObservableType`, `SharedSequence` (aka `Driver`) and `Single`.
- **Add**: `Completable.deferredJust(:)` static method.
- **Add**: `ViewTextConfigurable` protocol. Conform `UILabel`, `UITextField` and `UIButton` to this protocol.
- **Add**: `BaseTextAttributes` with base text appearance attributes.
- **Update**: `ViewText.string` now uses `BaseTextAttributes` instead of separate properties.
- **Add**: `BasePlaceholderView` and `BasePlaceholderViewModel` classes used to create your own placeholder.
- **Add**: `TableKitViewModel` protocol that adds convenient extensions to cell view models that implements it.

### 0.8.8
- **Update**: Update `DateFormat` protocol. Add `dateToStringFormat` and `stringToDateFormat` according to SwiftDate 5.0.
- **Update**: Replace `String` with `DateFormat` in `DataFormattingService` date parsing methods.
- **Update**: Replace `DateInRegion` with `DateRepresentable` in `DataFormattingService` string formatting methods.
- **Add**: `parsedIn` optional parameter to date parsing method in `DataFormattingService`.

### 0.8.7
- **Add**: Base configurable controllers hierarchy with generic custom view argument (`BaseConfigurableController`, `BaseCustomViewController`, `BaseScrollContentController`, `BaseTableContentController` and `BaseCollectionContentController`).
- **Add**: `ScrollViewHolder`, `TableViewHolder` and `CollectionViewHolder` protocols.
- **Update**: Update dependencies.
- **[Breaking change]**: Update `SwiftDate` to 5.0.x.
- **[Breaking change]**: Update `DateFormattingService`. Change `format` argument from `DateFormatType` to `String`.
- **Update**: Add compile time debug messages. Improve compile time for some pieces of code.

### 0.8.6

- **Fix**: Add `trustPolicies` param to `NetworkServiceConfiguration` initialization.
- **Fix**: Update `serverTrustPolicies` to save host instead of the whole URL as a key.  
- **Add**: String extension that extracts host.

### 0.8.5

- **Add**: `replaceDataSource` method to `RxNetworkOperationModel`.
- **Add**: `customErrorHandler` constructor parameter to `RxNetworkOperationModel` and it heirs.

### 0.8.4

- **Fix**: Add `SeparatorCell` to `Core-iOS-Extension`.
- **Fix**: `UIApplication` extensions path for `Core-iOS-Extension` exclusions.

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
