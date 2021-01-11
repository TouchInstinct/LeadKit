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

public typealias RxPaginationDataLoadingModel<Cursor: ResettableRxDataSourceCursor> =
    RxDataLoadingModel<PaginationDataLoadingState<Cursor>>

/// Data loading model for PaginationDataLoadingState with ResettableRxDataSourceCursor as data source.
public final class PaginationDataLoadingModel<Cursor: ResettableRxDataSourceCursor>: RxPaginationDataLoadingModel<Cursor> {

    private enum LoadType {

        case reload
        case retry
        case next
    }

    override public func reload() {
        load(.reload)
    }

    /// Attempt to load data again.
    public func retry() {
        load(.retry)
    }

    public func loadMore() {
        load(.next)
    }

    private func load(_ loadType: LoadType) {
        currentRequestDisposable?.dispose()

        switch loadType {
        case .reload, .retry:
            replaceDataSource(with: dataSource.reset())

            if loadType == .retry {
                state = .initial
            }

            state = .initialLoading(after: state)

        case .next:
            if case .exhausted = state {
                fatalError("You shouldn't call load(.next) after got .exhausted state!")
            }

            state = .loadingMore(after: state)
        }

        requestResult(from: dataSource)
    }

    override func onGot(error: Error) {
        if case .exhausted? = error as? CursorError, case .initialLoading(let after) = state {
            switch after {
            case .initial, .empty: // cursor exhausted after creation
                state = .empty

            default:
                super.onGot(error: error)
            }
        } else {
            super.onGot(error: error)
        }
    }

    override func updateStateAfterResult(from dataSource: DataSourceType) {
        if dataSource.exhausted {
            state = .exhausted
        }
    }
}
