# TIUIKitCore

Core UI elements: protocols, views and helpers.

# Protocols

- [InitializableView](Sources/InitializableView/InitializableViewProtocol.swift) - protocol with methods that should be called in constructor methods of view.
- [Animatable](Sources/ActivityIndicator/Animatable.swift) - protocol that ensures that specific type support basic animation actions.
- [ActivityIndicator](Sources/ActivityIndicator/ActivityIndicator.swift) - basic activity indicator.
- [ActivityIndicatorHolder](Sources/ActivityIndicator/ActivityIndicatorHolder.swift) - placeholder view, containing activity indicator.
- [AlertLocalizationProvider](Sources/Localization/AlertsLocalization/AlertLocalizationProvider.swift) - protocol that ensures that localization for alerts will be provided.
- [AlertPresentable](Sources/Alerts/Protocols/AlertPresentable.swift) - protocol indicates that certain object can present alerts.
- [AlertPresentationContext](Sources/Alerts/Protocols/AlertPresentationContext.swift) - protocol indicates that certain object can present alert on top of itself.
- [UIKitAlertContext](Sources/Alerts/Protocols/UIKitAlertContext.swift) - helper to provide easy conformance of `UIViewController` to `AlertPresentationContext`.

# Models

- [DefaultAlertLocalizationProvider](Sources/Localization/AlertsLocalization/DefaultAlertLocalizationProvider.swift) - default localization provider for alerts.
- [AlertAction](Sources/Alerts/Models/AlertAction.swift) - representation of alert action
- [AlertDescriptor](Sources/Alerts/Models/AlertDescriptor.swift) - struct that holds all needed information to present alert

# Factories

- [AlertsFactory](Sources/Alerts/Factories/AlertFactory.swift) - factory to present alerts.

## AlertsFactory
Use to present alerts in a few lines of code. Can be used for UIKit and SwiftUI
> You can initialize `AlertsFactory` with your own *LocalizationProvider* or use `DefaultAlertLocalizationProvider`

### Your view or view controller must implement PresentationContext protocol
There are `UIKitAlertContext` protocol that are designed to make it easier to work with `AlertPresentationContext` protocol. By default, no changes need to be made for UIKit view controllers to make them conform to `UIKitAlertContext`. 

## Custom alerts
```swift
// Presents alert
func presentAlert() {
    factory
        .alert(title: "Alert's title",
               message: "Alert's message",
               tint: .systemBlue,
               actions: [
                   AlertAction(title: "Ok", style: .default, action: nil),
                   AlertAction(title: "Cancel", style: .cancel, action: nil)
               ])
        .present(on: self)
}

// Presents sheet alert
func presentSheetAlert() {
    factory
        .sheetAlert(title: "Alert's title",
               message: "Alert's message",
               tint: .systemBlue,
               actions: [
                   AlertAction(title: "Ok", style: .default, action: nil),
                   AlertAction(title: "Cancel", style: .cancel, action: nil)
               ])
        .present(on: self)
}
```

## Default alerts
```swift
// Ok alert
func presentOkAlert() {
    factory
        .okAlert(title: "Title", message: "Message")
        .present(on: self)
}

// Retry alert
func presentRetryAlert() {
    factory
        .retryAlert(title: "Title", message: "Message") { [weak self] in
            self?.presentOkAlert()
        }
        .present(on: self)
}

// Dialogue alert
func presentDialogueAlert() {
    factory
        .dialogueAlert(title: "Title", message: "Message")
        .present(on: self)
}
```

# Installation via SPM

You can install this framework as a target of LeadKit.
