
# `AsyncOperation<Result, Error>` - generic сабкласс Operation

Позволяет запускать:

- асинхронный код внутри операции
- собирать цепочки из операций
- подписываться на результат выполнения

## Базовые операции

 "Из коробки", на данный момент, доступен всего один сабкласс асинхронной операции, потому что больше обычно и не нужно.
 Но можно наследоваться и создавать собственные сабклассы при необходимости.

### `ClosureAsyncOperation<Result, Error>`

 Операция принимающая некий closure, который по окончании своей работы вызовет completion, переданный ему параметром

```swift
import Foundation
import TIFoundationUtils

let intResultOperation = ClosureAsyncOperation<Int, Never> { completion in
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
        completion(.success(1))
    }
    return Cancellables.nonCancellable()
}
```

## Базовые операторы

 На данный момент реализовано всего два оператора:

 - `map(mapOutput:mapFailure:)` - конвертирует ResultType в новый NewResultType и ErrorType в новый NewErrorType
 - `observe(onSuccess:onFailure)` - просто вызывает переданные callback'и при получении результата или ошибки


### Пример запуска асинхронных операци с применением операторов в последовательной очереди и вывод результатов

```swift
let operationQueue = OperationQueue()
operationQueue.maxConcurrentOperationCount = 1

ClosureAsyncOperation<Int, Never> { completion in
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
        completion(.success(1))
    }
    return Cancellables.nonCancellable()
}
.map { $0 * 2 }
.observe(onSuccess: { result in
    debugPrint("Async operation one has finished with \(result)")
})
.add(to: operationQueue)

ClosureAsyncOperation<String, Never> { completion in
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
        completion(.success("Success"))
    }
    return Cancellables.nonCancellable()
}
.observe(onSuccess: { result in
    debugPrint("Async operation two has finished with \(result)")
})
.add(to: operationQueue)
```

 В консоли будет выведено:

 ```
 "Async operation one has finished with 2"
 "Async operation two has finished with Success"
 ```
