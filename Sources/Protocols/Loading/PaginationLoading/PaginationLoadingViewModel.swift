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

public typealias ResettableCursorType = CursorType & ResettableType
public typealias ResettableCursorDataSource = ResettableCursorType & DataSourceProtocol

public final class PaginationLoadingViewModel<C: ResettableCursorDataSource>:
    LoadingViewModel<PaginationLoadingViewModelConfiguration<C>>
    where C.ResultType == [C.Element] {

    private enum LoadType {

        case reload
        case retry
        case next

    }

    private let configuration: PaginationLoadingViewModelConfiguration<C>

    public required init(configuration: PaginationLoadingViewModelConfiguration<C>) {
        self.configuration = configuration

        super.init(configuration: configuration)
    }

    override public func reload() {
        load(.reload)
    }

    override public func retry() {
        load(.retry)
    }

    public func loadMore() {
        load(.next)
    }

    private func load(_ loadType: LoadType) {
        switch loadType {
        case .reload, .retry:
            configuration.resetDataSource()

            configuration.state = .loading(after: configuration.state)
        case .next:
            if case .exhausted = configuration.state {
                fatalError("You shouldn't call load(.next) after got .exhausted state!")
            }

            configuration.state = .loadingMore(after: configuration.state)
        }

        let currentDataSource = configuration.dataSource

        let currentRequestDisposable = configuration.loadingObservable
            .subscribeOn(configuration.scheduler)
            .subscribe(onSuccess: { [weak self] newItems in
                self?.onGot(result: newItems, from: currentDataSource)
            }, onError: { [weak self] error in
                self?.onGot(error: error)
            })

        configuration.storeCurrentRequestDisposable(currentRequestDisposable)
    }

    override func onGot(result: DataSourceType.ResultType, from dataSource: DataSourceType) {
        super.onGot(result: result, from: dataSource)

        if !configuration.isEmptyResult(result: result) && dataSource.exhausted {
            configuration.state = .exhausted
        }
    }

    override func onGot(error: Error) {
        if case .exhausted? = error as? CursorError, case .loading(let after) = configuration.state {
            switch after {
            case .initial, .empty: // cursor exhausted after creation
                configuration.state = .empty
            default:
                super.onGot(error: error)
            }
        } else {
            super.onGot(error: error)
        }
    }

}
