# TIActivityIndicators

Bunch of protocols and views of Activity Indicators.

# Protocols 

## ActivityIndicator
Protocol that describes basic activity indicator which conforms to Animatable.

```swift

public protocol ActivityIndicator {

    /// Type of view. Should be instance of UIView with basic animation actions.
    associatedtype View: UIView, Animatable

    /// The underlying view.
    var view: View { get }
}
```

## ActivityIndicatorHolder
Protocol that describes placeholder view, containing activity indicator.

```swift

public protocol ActivityIndicatorHolder: class {
    var activityIndicator: Animatable { get }
    var indicatorOwner: UIView { get }
}
```

# Views

## AnyActivityIndicator
Type that performs some kind of type erasure for ActivityIndicator.

# Usage examples

- Loading Indicator in [PaginationWrapperUIDelegate](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Extensions/DataLoading/PaginationDataLoading/PaginationWrapperUIDelegate+DefaultImplementation.swift) of main framework LeadKit.

# Installation via SPM

You can install this framework as a target of LeadKit.
