//
//  Sequence+ConcurrentMap.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import RxSwift

public typealias ConcurrentMapCancelClosure = () -> ()

public extension Sequence {

    /// Method which asynchronous transforms sequence using given transform closure
    /// and given number of concurrent operations
    ///
    /// - Parameters:
    ///   - transform: Transform closure
    ///   - concurrentOperationCount: Number of concurrent operations
    ///   - completion: Completion handler with results of transform
    /// - Returns: Closure whitch can be called to cancel asynchronous operation
    @discardableResult
    func concurrentMap<R>(transform: @escaping ((Iterator.Element) throws -> R),
                       concurrentOperationCount: Int = ProcessInfo.processInfo.activeProcessorCount,
                       completion: @escaping (([R]) -> ())) -> ConcurrentMapCancelClosure {

        let operationsCount = Swift.max(1, concurrentOperationCount)

        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = operationsCount

        let array = Array(self)

        let step = Int(ceil(Double(array.count) / Double(operationsCount)))
        let numberOfSlices = Int(ceil(Double(array.count) / Double(step)))

        DispatchQueue.global().async {
            let operations: [ResultOperation<[R]>] = (0..<numberOfSlices).map {
                let start = $0 * step
                let end = Swift.min(start + step, array.count)

                return ResultOperation { try array[start..<end].map(transform) }
            }

            operationQueue.addOperations(operations, waitUntilFinished: true)

            var results: [R] = [] // var is used for performance optimization

            let operationsResults = operations.flatMap { $0.result }

            for operationResult in operationsResults {
                results += operationResult
            }

            completion(results)
        }

        return {
            operationQueue.cancelAllOperations()
        }
    }

}

public extension Sequence {

    /// Reactive version of concurrentMap<R>(transform:concurrentOperationCount:completion:)
    ///
    /// - Parameters:
    ///   - concurrentOperationCount: Number of concurrent operations
    ///   - transform: Transform closure
    /// - Returns: Observable of transform return type
    func concurrentRxMap<R>(concurrentOperationCount: Int = ProcessInfo.processInfo.activeProcessorCount,
                         transform: @escaping ((Iterator.Element) throws -> R)) -> Observable<[R]> {

        return Observable<[R]>.create { observer in
            let disposeHandler = self.concurrentMap(transform: transform,
                                                    concurrentOperationCount: concurrentOperationCount) {
                                                        observer.onNext($0)
                                                        observer.onCompleted()
            }
            
            return Disposables.create(with: disposeHandler)
        }
    }
    
}