# TILogging

## Logger usage

```swift
let logger = TILogger.defaultLogger

// string interpolation
logger.log(type: .default, "🐈 Hello from \(someName), I'm machine number \(someNumer)")

// passing CVarArgs
logger.log("🐈 Hello from %@, I'm machine number %i", type: .default, someName, someNumber)
```

To pass arguments to a logging string it is essantial to pass valid formatting specifiers

| Specifier | Type | Usage |
| --------- | ---- | ----- |
| `%i`, `%d` | `Int` | `logger.verbose("🎉 int %i", 1)` |
| `%f` | `Float` | `logger.verbose("🎉 float %f", Float(1.23))` |
| `%f` | `Double` | `logger.verbose("🎉 double %f", Double(1.23))` |
| `%@` | `String` | `logger.verbose("🎉 string %@", "String")` |

> For more information about string format specifiers check the [documentation](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html)
