# OTPSwiftView

![Platform](https://img.shields.io/badge/platform-iOS-green)

A fully customizable OTP view.

<p align="left">
<img src="Assets/preview.gif" width=300 height=533>  
</p> 

# Usage
```swift 
class ViewController: UIViewController {
    let otpView = CustomOTPSwiftView() // Custom OTP view

    let config = OTPCodeConfig(codeSymbolsCount: 6, // Base configuration of OTP view
                               spacing: 6,
                               customSpacing: [2: 20])

    override func viewDidLoad() {
        super.viewDidLoad()

        /* 
          Add your codeView and set layout 
        */
        
        /* Configure OTP view */
        
        otpView.configure(with: config)
        
        /* Bind events */
        
        otpView.onTextEnter = { code in
            // Get code from codeView
        }
        
        /* Update text */
        
        otpView.code = "234435"
        
        /* Update focus */
        
        otpView.beginFirstResponder() // show keyboard
        otpView.resignFirstResponder() // hide keyboard
    }
}
```

# Customization 
## Single OTP View
*OTPView* is a base class that describes a single OTP textfield.  
To customize the appearance and layout, you must inherit from the OTPView.  
*Don't forget to add UIGestureRecognizer to call closure `onTap?()`. Use UITapGestureRecognizer to avoid bugs.*

```swift
import OTPSwiftView

class CustomOTPView: OTPView {
    override func addViews() {
        super.addViews()
        
        // Adding additional views to current view. The OTP textfield has already been added.
    }
    
    override func configureLayout() {
        super.configureLayout()
    
        // Confgiure layout of subviews
    }
    
    override func bindViews() {
        super.bindViews()
        
        // Binding to data or user actions
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapAction))
        addGestureRecognizer(gesture)
    }
    
    private func onTapAction() {
        onTap?()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        // Appearance configuration method
    }
}
```

*If needed to set validation for input use `validationClosure: ValidationClosure<String>?`*. For example, only numbers validation:

```swift
import OTPSwiftView

class CustomOTPView: OTPView {

    override func bindViews() {
        super.bindViews()
        
        codeTextField.validationClosure = { input in
            input.allSatisfy { $0.isNumber }
        }
    }
}
```

## OTPSwiftView
*OTPSwiftView* is a base class that is responsible for the layout of single OTP views.  
As with OTPView, you should create an heir class to configure your full OTP view.

```swift
import OTPSwiftView

final class CustomOTPSwiftView: OTPSwiftView<CustomOTPView> {
    override func addViews() {
        super.addViews()
        
        // Adding additional views to current code view. The single OTP views has already been added.
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        // Confgiure layout of subviews
    }
    
    override func bindViews() {
        super.bindViews()
        
        // Binding to data or user actions
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        // Appearance configuration method
    }

    override func configure(with config: OTPCodeConfig) {
        super.configure(with: config)

        // Configure you code view with configuration
    }
}
```

# Installation via SPM

You can install this framework as a target of LeadKit.
