# Changelog

## 0.5.6

- **Fix**: Clear tableview if placeholder is shown

## 0.5.7

- **Add**: String extension `localizedComponent(value:stringOne:stringTwo:stringMany:)`

## 0.5.8

- **Fix**: Synchronization over `NSRecursiveLock` for request count tracker in NetworkService

## 0.5.9

- **Fix**: One-two-many fixed for values more than 99

## 0.5.10

- **Fix**: `Public` modifier for `SpinnerView` 

## 0.5.11

- **[Breaking Change]**: rename initializer from `init(initialFrom:)` to `init(resetFrom:)` in `ResettableType`
- **Add**: `SeparatorCell` with `SeparatorCellViewModel`
- **Add**: `AnyBaseTableRow` for type-erasure
- **Add**: `EmptyCellRow` for empty cell with static height

## 0.5.12

- **Fix**: Update type of `viewModel` in `ConfigurableController` to `ImplicitlyUwrappedOptional<ViewModelT>` instead of `ViewModelT`