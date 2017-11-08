//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import RxSwift
import RxCocoa

public final class TotalCountCursor<LT, ET, CC: TotalCountCursorConfiguration>: ResettableCursorDataSource
    where CC.ListingType == LT, CC.ElementType == ET {

    public typealias Element = ET
    public typealias ResultType = [ET]

    private let configuration: CC

    private let elementsVariable = Variable<[ET]>([])
    private let totalCountVariable = Variable<Int>(.max)

    public var totalCount: Int {
        return totalCountVariable.value
    }

    private let disposeBag = DisposeBag()

    public var exhausted: Bool {
        return count >= totalCount
    }

    public var count: Int {
        return elementsVariable.value.count
    }

    public subscript(index: Int) -> ET {
        return elementsVariable.value[index]
    }

    public init(configuration: CC) {
        self.configuration = configuration
    }

    public required init(resetFrom other: TotalCountCursor) {
        self.configuration = other.configuration.reset()
    }

    public func loadNextBatch() -> Single<[ET]> {
        let sharedListing = configuration.nextBatchObservable()
            .map { [configuration] listing in
                configuration.getResult(from: listing)
            }

        let driverListing = sharedListing
            .asDriver(onErrorJustReturn: CC.ResultTuple([], .max))

        driverListing
            .map { $0.totalCount }
            .filter { $0 != .max }
            .drive(totalCountVariable)
            .disposed(by: disposeBag)

        let newProductsDriver = driverListing
            .map { $0.results }
            .filterEmpty()

        Driver
            .combineLatest(newProductsDriver, Driver.just(elementsVariable.value)) {
                $0 + $1
            }
            .drive(elementsVariable)
            .disposed(by: disposeBag)

        return sharedListing
            .map { $0.results }
            .asObservable()
            .asSingle()
            .exhaustedIfEmpty()
    }

}
