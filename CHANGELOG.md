# Changelog

### 1.35.1

- **Added**: Auto documentation generation for `TIFoundationUtils` playground and compile checks for playground before release
- **Updated**: `AsyncOperation` fixed ordering of chain operations execution

### 1.35.0

- **Added**: `TIDeveloperUtils` framework, that contains different utils for development
- **Added**: `UIView` and `UIViewController` extensions for showing SwiftUI previews
- **Added**: `DashedBoundsLayer` for debugging views' frames visually

### 1.34.0

- **Added**: `BaseListItemView` for displaying three views horizontally
- **Added**: `DefaultTitleSubtitleView` for displaying one or two labels vertically
- **Update**: `StatefulButton` now can be configured with `ViewAppearance` model for each state

### 1.33.0

- **Added**: `ViewAppearance` and `ViewLayout` models for setting up Views' appearance and layout
- **Added**: `TableKit.Row` extension for configuration inner View's appearance and layout
- **Added**: `WrappableView` with typealiases for creating wrapped in the container views
- **Added**: `CollectionTableViewCell` and `ContainerView`
- **Update**: Separator appearance configureation for table views

### 1.32.0

- **Added**: `BaseInitializableWebView` with navigation and error handling api.

### 1.31.0

- **Added**: `URLInteractiveTextView` for terms and conditions hints in login flow

### 1.30.0

- **Added**: Base classes for encryption and decryption user token with pin code or biometry
- **Added**: Pin code validators

### 1.29.1

- **Updated**: `BaseTextAttributes` correct detection of the necessity of using attributed string

### 1.29.0

- **Added**: `BaseTextAttributes`can now measure text size and provides paragraph style configuration API.
- **Removed**: `ViewText`. Was fully replaced with `BaseTextAttributes`
- **Fixed**: `Operation.flattenDependencies` used in `Operation.add(to:waitUntilFinished:)` now works correctly.
- **Added**: Now it's possible to add dependent operation to start of the queue.

### 1.28.0

- **Add**: `LoggingPresenter`to present list of logs with ability of sharing it
- **Add**: `TILogger` wrapper object to log events.

### 1.27.1

- **Fix**: Weak target reference in `RefreshControl`

### 1.27.0

- **Add**: Tag like filter collection view
- **Add**: List like filter table view
- **Add**: Range like filter view

### 1.26.3
- **Update**: Add @escaping in `RequestExecutor.ExecutionClosure`

### 1.26.2
- **Update**: Add failureCompletion in `RequestExecutor`

### 1.26.1
- **Fix**: Use OperationQueue instead of NSLock in `DefaultTokenInterceptor`
- **Update**: AsyncOperation refactoring

### 1.26.0

- **Add**: `TIEcommerce` module with Cart, products, promocodes, bonuses and other related actions.

### 1.25.0

- **Update**: `RequestError` cases now contain additional url assotiated value
- **Update**: Network requests error catching now throws `RequestError` with url

### 1.24.0

- **Add**: `AlertFactory` for presenting alerts in SwiftUI and UIKit.

### 1.23.0

- **Update**: `UITextView` now support configuration with `BaseTextAttributes`
- **Add**: `ReconfigurableView` & `ChangeableViewModel` for non-destructing state update
- **Add**: `WrappedViewHolder` protocol with table/collection view cell implementations
- **Add**: `UIViewPresenter` and `ReusableUIViewPresenter` protocols with default implementation for proper handling view/cells reuse

### 1.22.0

- **Update**: Asynchronous request preprocessing

### 1.21.0

- **Update**: `AsyncEventHandler` was replaced with `EndpointRequestRetrier`
- **Add**: `FingerprintsTrustEvaluator` and `FingerprintsProvider` for fingerprint-based host trust evaluation
- **Add**: `DefaultTokenInterceptor` for queue-based token refresh across all requests of single api interactor (network service).
- **Update**: `DefaultRecoverableJsonNetworkService` now returns collection of errors in result
- **Update**: `CancellableTask` was renamed to `Cancellable`. Cancellable implementations has been moved from `TIMoyaNetworking` to `TIFoundationUtils`.
- **Add**: `ApiInteractor` protocol with basic request/response methods


### 1.20.0

- **Add**: OpenAPI security schemes support for EndpointRequest's.
- **Update**: Replace `AdditionalHeadersPlugin` with `SecuritySchemePreprocessor` and `EndpointRequestPreprocessor` (with default implementations)

### 1.19.0

- **Add**: Add presenter protocols to `TISwiftUICore` and `TIUIKitCore` modules
- **Add**: `CodeConfirmPresenter` protocol and `DefaultCodeConfirmPresenter` implementation in `TIAuth` module

### 1.18.0

- **Add**: add MapManagers for routine maps configuration

### 1.17.0

- **Add**: add smooth CameraUpdate actions for supported maps

### 1.16.2

- **Update**: `DefaultRecoverableJsonNetworkService` now supports error forwarding from its error handlers to initial requests.

### 1.16.1

- **Update**: `DateFormattersReusePool` and  `ISO8601DateFormattersReusePool` are now thread safe.

### 1.16.0

- **Add**: `TIMapUtils`, `TIAppleMapUtils`, `TIGoogleMapUtils` and `TIYandexMapUtils` modules for map items clustering and interacting with them.

### 1.15.0

- **Update**: Network services in TIMoyaNetworking now passes MoyaError in result of EnpointRequest execution.
- **Add**: `TINetworkingCache` module - caching results of EndpointRequests.
- **Important Note**: `TINetworkingCache` added via SPM may require you to add `DISABLE_DIAMOND_PROBLEM_DIAGNOSTIC=YES` flag to build settings of project target (see [probably related problem](https://forums.swift.org/t/adding-a-package-to-two-targets-in-one-projects-results-in-an-error/35007/18))

### 1.14.3

- **Fix**: Creating headerView and footerView when initializing a section with rows in `TITableKitUtils`.
- **Add**: Empty table section initialization method in `TITableKitUtils`.

### 1.14.2

- **Update**: DateFormatters properties preset in reuse pools

### 1.14.1

- **Fix**: Array encoding for `QueryStringParameterEncoding`

### 1.14.0

- **Add**: [Date] coding methods

### 1.13.0

- **Update**: Change access modifiers in `DefaultJsonNetworkService` from `public` to `open`, added additional Moya plugins processing
- **Add**: `DisplayDecodingErrorPlugin` for showing developer-frendly decoding error messages
- **Add**: Gemfile for cocoapods versioning

### 1.12.3

- **Fix**: Try parse date in ISO8601 format appending `.withFractionalSeconds` if `.withInternetDateTime` fails

### 1.12.2

- **Fix**: HeaderParameterEncoding encodes array correctly 

### 1.12.1

- **Update**: DefaultRecoverableNetworkService `request` parameter was renamed to prevent ambgious reference

### 1.12.0

- **Update**: EndpointRequest Body can take a nil value
- **Update**: Parameter value can be nil as well
- **Update**: observe operator of AsyncOperation now accepts callback queue parameter

### 1.11.1
- **Fix**: `timeoutIntervalForRequest` parameter for `URLSessionConfiguration` in `NetworkServiceConfiguration` added.

### 1.11.0
- **Breaking changes**: many method signatures was changes in `TIMoyaNetworking`.
- **Add**: `ISO8601DateFormattersReusePool` and codable helpers for ISO8601 date (de)coding.
- **Add**: Moya plugin protocol for adding HTTP headers with default implementation.

### 1.10.0
- **Add**: `DefaultRecoverableJsonNetworkService` with error handling chain.


### 1.9.0
- **Add**: `TIMoyaNetworking` target - Moya + Swagger network service.
- **Update**: `TISwiftUtils` - added async closure typealiases.
- **Update**: `TIFoundationUtils` - added date formatting & decoding helpers.

### 1.8.0
- **Add**: `TIFoundationUtils.AsyncOperation` - generic subclass of Operation with chaining and result observation support

### 1.7.0
- **Add**: `TINetworking` - Swagger-frendly networking layer helpers

### 1.6.0
- **Add**: the pretty timer - TITimer.

### 1.5.0
- **Add**: `HeaderTransitionDelegate` - Helper for transition of TableView header and navigationBar title view

### 1.4.0
- **Update**: update minor dependencies.
- **Fix**: project's scripts.

### 1.3.0
- **Add**: `TIPaginator` - realisation of paginating items from a data source.

### 1.2.0
- **Add**: `TIKeychainUtils` - Set of helpers for Keychain classes.

### 1.1.1
- **Fix**: `StatefullButton` propagation

### 1.1.0
- **Add**: `BaseInitializeableViewController`, `BaseCustomViewController` and `BaseViewController` to TIUIKitCore.
- **Add**: `TableKitTableView` and `TableDirectorHolder` to TITableKitUtils.

### 1.0.0
- **API BreakingChanges**: up swift version to 5.1.
- **Update**: build scripts.
- **Update**: code with new swiftlint rules.
- **Update**: RxSwift to 6.0.0.

### 0.13.1
- **Fix**: LeadKit.podspec file.

### 0.13.0
- **Add**: Githook `prepare-commit-msg` to check commit's style.
- **Add**: Setup script.

### 0.12.0
- **Add**: StatefulButton & RoundedStatefulButton to TIUIElements.
- **Add**: added CACornerMask rounding extension to TIUIElements.
- **Add**: UIControl.State dictionary extensions to TIUIKitCore.
- **Add**: UIFont and CTFont extensions to TIUIKitCore.
- **Breaking change**: reworked BaseTextAttributes & ViewText. Removed ViewTextConfigurable protocol & conformances.

### 0.11.0
- **Add**: Cocoapods support for TI-family libraries.
- **Add**: `SeparatorConfigurable` and all helper types for separator configuration.
- **Add**: `BaseSeparatorCell` - `BaseInitializeableCell` subclass with separators support. 
- **Add**: `TITableKitUtils` - set of helpers for TableKit classes.
- **Add**: `BaseTextAttributes` and `ViewText` implementation form LeadKit.
- **Update**: `BaseInitializableView` and `BaseInitializableControl` are moved to `TIUIElements` from `TIUIKitCore`.

### 0.10.9
- **Fix**: `change presentedOrTopViewController to open`.

### 0.10.8
- **Fix**: `Add presentedOrTopViewController`.

### 0.10.7
- **Fix**: `Add BaseOrientationController`.
- **Fix**: `Add videoOrientation extension`.

### 0.10.6
- **Fix**: `Add tvos exclude files`.

### 0.10.5
- **Add**: `OrientationNavigationController` .
- **Add**: `Forced Interface Orientation logic to BaseConfigurableController` .
- **Fix**: `Exclude files to watchos and tvos`.

### 0.10.4
- **Fix**: `noConnection` error.

### 0.10.3
- **Fix**: `mappingQueue` of `SessionManager`.

### 0.10.2
- **Add**: `RefreshControl` - a basic UIRefreshControl with fixed refresh action.

### 0.10.1
- **Update**: Third party dependencies:  `Alamofire` 5.2.2, `RxAlamofire` 5.6.1

### 0.10.0
- **Update**: Third party dependencies: `RxSwift` (and all sub-dependencies) to 5.1.0, `Alamofire` 5.0, `SnapKit` 5.0
- **Refactored**: NetworkManager to use new Alamofire API
- **API BreakingChanges**: NetworkServiceConfiguration no longer accepts `ServerTrustPolicy`, it is now replaced by an instance of a `ServerTrustEvaluating` protocol. Full description and default implementations can be found at Alamofire [sources](https://github.com/Alamofire/Alamofire/blob/master/Source/ServerTrustEvaluation.swift). Since new evaluation is used, evaluation against self-signed certificates will now throw an AfError and abort any outcoming request. To support self-signed certificates use `DisabledTrustEvaluator` for specified host in configuration.
- **Removed**: UIImage+SupportExtensions, UIScrollView+Support

### 0.9.44
- **Add**: `TIFoundationUtils` - set of helpers for Foundation framework classes.

#### TISwiftUtils
- **Add**: `BackingStore` - a property wrapper that wraps storage and defines getter and setter for accessing value from it.

#### TIFoundationUtils
- **Add**: `CodableKeyValueStorage` - storage that can get and set codable objects by the key.

### 0.9.43
- **Fix**: `OTPSwiftView`'s dependencies.

### 0.9.42
- **Fix**: Logic bugs of `PaginationWrapper`.

### 0.9.41
- **Add**: `OTPSwiftView` - a fully customizable OTP view.
- **Add**: `BaseInitializableControl` UIControl conformance to InitializableView.
- **Add**: `TISwiftUtils` a bunch of useful helpers for development.

### 0.9.40
- **Fix**: Load more request repetion in `PaginationWrapper`.

### 0.9.39
- **Add**: `Animatable` protocol to TIUIKitCore.
- **Add**: `ActivityIndicator` protocol to TIUIKitCore.
- **Add**: `ActivityIndicatorHolder` protocol to TIUIKitCore.
- **Add**: `TIUIElements` for ui elements.

### 0.9.38
- **Add**: `BaseRxTableViewCell` is subclass of `UITableViewCell` class with support `InitializableView` and `DisposeBagHolder` protocols.
- **Add**: `ContainerTableCell` is container class that provides wrapping any `UIView` into `UITableViewCell`.
- **Add**: `BaseTappableViewModel` is simplifies interaction between view and viewModel for events of tapping.
- **Add**: `VoidTappableViewModel` is subclass of `BaseTappableViewModel` class with void payload type.

### 0.9.37
- **Fix**: ScrollView content offset of `PaginationWrapper` for iOS 13.
- **Fix**: Load more request crash of `PaginationWrapper`.

### 0.9.36
- **Add**: SPM Package.swift.
- **Add**: TITransitions via SPM.
- **Add**: TIUIKitCore via SPM.
- **Update**: Readme.

### 0.9.35
- **Add**: Selector `refreshAction()` for refresh control of `PaginationWrapper`.

### 0.9.34
- **Add**: `ButtonHolder` - protocol that contains button property.
- **Add**: `ButtonHolderView` - view which contains button.
- **Add**: Conformance `UIButton` to `ButtonHolder`.
- **Add**: Conformance `BasePlaceholderView` to `ButtonHolderView`.
- **[Breaking change]**: Replace functions `footerRetryButton() -> UIButton?` to `footerRetryView() -> ButtonHolderView?` and `footerRetryButtonHeight() -> CGFloat` to `footerRetryViewHeight() -> CGFloat` for `PaginationWrapperUIDelegate`. 
- **[Breaking change]**: Replace functions `footerRetryButtonWillAppear()` to `footerRetryViewWillAppear()` and `footerRetryButtonWillDisappear()` to `footerRetryViewWillDisappear()` for `PaginationWrapperUIDelegate`. 

### 0.9.33
- **Fix**: `CustomizableButtonView` container class that provides great customization.
- **Fix**: `CustomizableButtonViewModel` viewModel class for `CustomizableButtonView` configuration.

### 0.9.32
- **Fix**: `CustomizableButtonView` container class that provides great customization.

### 0.9.31
- **Add**: `@discardableResult` to function - `replace(with:at:with:manualBeginEndUpdates)` in `TableDirector`.

### 0.9.30
- **Add**: character `*` into a valid set of characters in the extension `telpromptURL` of String.

### 0.9.29
- **Update**: remove Carthage binary dependencies, update build scripts.

### 0.9.28
- **Add**: method `presentFullScreen(_ viewController:presentationStyle:animated:completion:)` for `UIViewController` that present any `viewController` modally in full screen mode by default (avoid problems with *iOS13* default presentation mode changed to `.automatic` stork)

### 0.9.27
- **Add**: method `date(from string:formats:parsedIn:)` method for `DateFormattingService` that parses date from string in one of the given formats with current region.

### 0.9.26
- **Add**: method `processResultFromConfigurationSingle` for `TotalCountCursor` that allows to get server response.
- **Add**: possibility to inherit from `TotalCountCursor`.

### 0.9.25
- **Add**: `queryItems` parameter for `ApiRequestParameters`.
- **Add**: `asQueryItems` method for `Encodable` that converts model to query items array.

### 0.9.24
- **Fix**: Make `ApiRequestParameters` properties public.

### 0.9.23
- **Add**: Rounding for `Decimal`.
- **Add**: `doubleValue` property for `Decimal`.
- **Add**: `intValue` property for `Decimal`.
- **Fix**: Rounding for `Double`.

### 0.9.22
- **Fix**: Make `Initializable` protocol public.

### 0.9.21
- **Add**: `Initializable` - common protocol for object types that can be initialized without params.
- **Add**: `instantiateArray(count:)` function in `Initializable` extension to initialize an array of instances.

### 0.9.20
- **Fix**: `bindBottomInsetBinding(from bottomInsetDriver:)` in `BaseScrollContentController` works correctly now.

### 0.9.19
- **Add**: `hexString` property for `UIColor` that returns hex representation of color as string.

### 0.9.18
- **Add**: `CustomizableButtonView` container class that provides great customization.
- **Add**: `CustomizableButtonViewModel` viewModel class for `CustomizableButtonView` configuration.
- **Add**: `CustomizableButton` class that is a `CustomizableButtonView` subview and gives it a button functionality.

### 0.9.17
- **Fix**: SpinnerView infinity animation.

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
