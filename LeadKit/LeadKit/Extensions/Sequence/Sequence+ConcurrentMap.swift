//
//  Sequence+ConcurrentMap.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import RxSwift

public extension Sequence {

    /// Method which asynchronous transforms sequence using given transform closure
    /// and given number of concurrent operations
    ///
    /// - Parameters:
    ///   - concurrentOperationCount: Number of concurrent operations
    ///   - qos: Target global dispatch queue, by quality of service class.
    ///   - transform: Transform closure
    /// - Returns: Observable of array which contains transform return type
    func concurrentRxMap<R>(concurrentOperationCount: Int = ProcessInfo.processInfo.activeProcessorCount,
                         qos: DispatchQoS = .default,
                         transform: @escaping ((Iterator.Element) throws -> R)) -> Observable<[R]> {

        let operationsCount = Swift.max(1, concurrentOperationCount)

        let array = Array(self)

        let step = Int(ceil(Double(array.count) / Double(operationsCount)))
        let numberOfSlices = Int(ceil(Double(array.count) / Double(step)))

        let indexedRanges: [(idx: Int, range: CountableRange<Int>)] = (0..<numberOfSlices).map {
            let start = $0 * step
            let end = Swift.min(start + step, array.count)

            return ($0, start..<end)
        }

        let scheduler = ConcurrentDispatchQueueScheduler(qos: qos)

        return Observable.from(indexedRanges)
            .flatMap { indexedRange -> Observable<(idx: Int, results: [R])> in
                return Observable.just(indexedRange)
                    .observeOn(scheduler)
                    .map { (idx: $0.idx, results: try array[$0.range].map(transform)) }
            }
            .toArray()
            .map { $0.sorted { $0.0.idx < $0.1.idx }.flatMap { $0.results } }
    }
    
}
