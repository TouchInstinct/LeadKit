# TISwiftUICore

Core UI elements: protocols, views and helpers.

## SwiftUI alerts

### SwiftUI views should conform to protocol `SwiftUIAlertContext` to present alerts. 
This means that the view must implement the presentingViewController property. This controller is a context from which the alert will be shown.

```swift
// View that can present alerts.
struct ContentView: View, SwiftUIAlerContext {
    var presentingViewController: UIViewController

    var body: some View {
        // View realization.
    }
}
```

## Alerts usage example

```swift
struct ContentView: View, SwiftUIAlertContext {

    private let factory = AlertFactory()

    @State private var alertDescription: AlertDescriptor
    @State private var isAlertPresented = false
    
    var presentingViewController: UIViewController

    var body: some View {
        Button("Show custom alert with binding property") {
                alertDescription = factory.okAlert(title: "Title", message: "Message")
                isAlertPresented = true
            }
        }
        .alert(isPresented: $isAlertPresented, on: self, alert: alertDescription)
    }
}
```

# Installation via SPM

You can install this framework as a target of LeadKit.