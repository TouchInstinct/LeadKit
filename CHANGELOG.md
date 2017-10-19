# Changelog

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

## 0.5.18
- **Fix**: EmptyCell first appearance setup fix

## 0.5.17
- **Fix**: EmptyCell reusing appearance fix
- **Fix**: SeparatorCell reusing separators fix

## 0.5.16

- **Change**: Rename `AppearanceProtocol` to `AppearanceConfigurable`
- **Add**: `subscript(safe:)` subscript to `Array` extension for safe access to element by index

## 0.5.15

- **Add**: `AppearanceProtocol` which ensures that specific type can apply appearance to itself
- **Add**: `with(appearance:)`,  `set(appearance:)`  methods to TableRow extension
- **Add**: `Appearance` to `EmptyCell`
- **Remove**: `SeparatorCellViewModel`.

## 0.5.13

- **Change**: Remove type erasure behavior from `AnyBaseTableRow`
- **Change**: Rename `AnyBaseTableRow` class to `SeparatorRowBox`
- **Change**: Move `anyRow` property from `EmptyCellRow` to `TableRow` extension and rename it to `separatorRowBox`.
- **Change**: Move `configure(extreme: middle:)` method from `TableDirector` extension to `Array` extension and rename it to `configureSeparators(extreme: middle:)`

## 0.5.12

- **Fix**: Update type of `viewModel` in `ConfigurableController` to `ImplicitlyUwrappedOptional<ViewModelT>` instead of `ViewModelT`

## 0.5.11

- **[Breaking Change]**: rename initializer from `init(initialFrom:)` to `init(resetFrom:)` in `ResettableType`
- **Add**: `SeparatorCell` with `SeparatorCellViewModel`
- **Add**: `AnyBaseTableRow` for type-erasure
- **Add**: `EmptyCellRow` for empty cell with static height

## 0.5.10

- **Fix**: `Public` modifier for `SpinnerView` 

## 0.5.9

- **Fix**: One-two-many fixed for values more than 99

## 0.5.8

- **Fix**: Synchronization over `NSRecursiveLock` for request count tracker in NetworkService

## 0.5.7

- **Add**: String extension `localizedComponent(value:stringOne:stringTwo:stringMany:)`

## 0.5.6

- **Fix**: Clear tableview if placeholder is shown



