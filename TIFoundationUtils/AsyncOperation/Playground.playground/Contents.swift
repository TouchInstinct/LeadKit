import Foundation
import TIFoundationUtils

let operationQueue = OperationQueue()
operationQueue.maxConcurrentOperationCount = 1

struct NonCancellableTask: CancellableTask {
    func cancel() {}
}

ClosureAsyncOperation<Int, Error> { completion in
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
        completion(.success(1))
    }
    return NonCancellableTask()

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
    return NonCancellableTask()
}
.map { $0 * 2 }
.observe(onSuccess: { result in
    debugPrint("Async operation two has finished with \(result)")
})
.add(to: operationQueue)

// "Async operation one has finished with 2"
// "Async operation two has finished with 4"

struct Some {
    var arr: [Int] = []

    mutating func add(_ i: Int) {
        arr.append(i)
    }
}
