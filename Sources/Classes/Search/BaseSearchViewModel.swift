//
//  Copyright (c) 2019 Touch Instinct
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

/// ViewModel that loads data from a given data source and performs search among results
open class BaseSearchViewModel<Item, ItemViewModel>: GeneralDataLoadingViewModel<[Item]> {

    public typealias ItemsList = [Item]

    private let searchTextRelay = BehaviorRelay(value: "")

    public init(dataSource: Single<ItemsList>) {
        super.init(dataSource: dataSource, emptyResultChecker: { $0.isEmpty })
    }

    open var itemsViewModelsDriver: Driver<[ItemViewModel]> {
        loadingResultObservable
            .map { [weak self] items in
                self?.viewModels(from: items)
            }
            .flatMap { Observable.from(optional: $0) }
            .share(replay: 1, scope: .forever)
            .asDriver(onErrorDriveWith: .empty())
    }

    open var searchDebounceInterval: RxTimeInterval {
        .seconds(1)
    }

    open var searchResultsDriver: Driver<[ItemViewModel]> {
        searchTextRelay.debounce(searchDebounceInterval, scheduler: MainScheduler.instance)
            .withLatestFrom(loadingResultObservable) { ($0, $1) }
            .flatMapLatest { [weak self] searchText, items -> Observable<ItemsList> in
                self?.search(by: searchText, from: items).asObservable() ?? .empty()
            }
            .compactMap { [weak self] items in
                self?.viewModels(from: items)
            }
            .flatMap { Observable.from(optional: $0) }
            .share(replay: 1, scope: .forever)
            .asDriver(onErrorDriveWith: .empty())
    }

    open func viewModel(from item: Item) -> ItemViewModel {
        fatalError("viewModel(from:) has not been implemented")
    }

    open func search(by searchString: String, from items: ItemsList) -> Single<ItemsList> {
        fatalError("searchEngine(for:) has not been implemented")
    }

    open func bind(searchText: Observable<String>) -> Disposable {
        searchText.bind(to: searchTextRelay)
    }

    private func viewModels(from items: ItemsList) -> [ItemViewModel] {
        items.map { self.viewModel(from: $0) }
    }

    open var loadingResultObservable: Observable<ResultType> {
        loadingStateDriver
            .asObservable()
            .map { $0.result }
            .flatMap { Observable.from(optional: $0) }
    }

    open var loadingErrorObservable: Observable<Error> {
        loadingStateDriver
            .asObservable()
            .map { $0.error }
            .flatMap { Observable.from(optional: $0) }
    }

    open var firstLoadingResultObservable: Single<ResultType> {
        loadingResultObservable
            .take(1)
            .asSingle()
    }
}
