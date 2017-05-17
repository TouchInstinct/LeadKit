//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
