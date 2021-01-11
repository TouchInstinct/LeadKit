//
//  Copyright (c) 2018 Touch Instinct
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

open class TotalCountCursor<CursorConfiguration: TotalCountCursorConfiguration>: ResettableRxDataSourceCursor {

    public typealias Element = CursorConfiguration.ResultType.ElementType
    public typealias ResultType = [Element]

    private let configuration: CursorConfiguration

    private var elements: [Element] = []

    public private(set) var totalCount: Int = .max

    public var exhausted: Bool {
        count >= totalCount
    }

    public var count: Int {
        elements.count
    }

    public subscript(index: Int) -> Element {
        elements[index]
    }

    public init(configuration: CursorConfiguration) {
        self.configuration = configuration
    }

    public required init(resetFrom other: TotalCountCursor) {
        configuration = other.configuration.reset()
    }

    open func processResultFromConfigurationSingle() -> Single<CursorConfiguration.ResultType> {
        configuration.resultSingle()
    }

    public func loadNextBatch() -> Single<[Element]> {
        processResultFromConfigurationSingle()
            .do(onSuccess: { [weak self] listingResult in
                self?.totalCount = listingResult.totalCount
                self?.elements = (self?.elements ?? []) + listingResult.results
            })
            .map {
                $0.results
            }
    }
}
