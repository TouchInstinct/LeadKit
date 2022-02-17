# AsyncOperation    

Generic subclass of Operation with chaining and result observation support.

## Examples

### Serial queue of async operations

Creating serial queue of async operations

```swift
import Foundation
import TIFoundationUtils

let operationQueue = OperationQueue()
operationQueue.maxConcurrentOperationCount = 1

ClosureAsyncOperation<Int, Error> { completion in
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
        completion(.success(1))
    }
}
.map { $0 * 2 }
.observe(onSuccess: { result in
    debugPrint("Async operation one has finished with \(result)")
})
.add(to: operationQueue)

ClosureAsyncOperation<Int, Error> { completion in
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
        completion(.success(2))
    }
}
.map { $0 * 2 }
.observe(onSuccess: { result in
    debugPrint("Async operation two has finished with \(result)")
})
.add(to: operationQueue)

// "Async operation one has finished with 2"
// "Async operation two has finished with 4"
```
