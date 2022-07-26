# TISwiftUICore

Core UI elements: protocols, views and helpers.

## SwiftUI alerts
> SwiftUI views should conform to protocol `SwiftUIAlertContext` to present alert

```swift
var body: some View {
    Button("Show custom alert with binding property") {
            alertDescription = factory.okAlert(title: "Title", message: "Message")
            isPresentedCustomAlert = true
        }
    }
    .alert(isPresented: $isPresentedAlert, on: self, alert: alertDescription)
}
```

# Installation via SPM

You can install this framework as a target of LeadKit.