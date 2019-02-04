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

open class BaseSearchViewModel<Item, ItemViewModel>: GeneralDataLoadingViewModel<[Item]> {

    typealias ItemsList = [Item]

    private let searchTextRelay = BehaviorRelay(value: "")

    init(dataSource: Single<ItemsList>) {
        super.init(dataSource: dataSource, emptyResultChecker: { _ in false })
    }

    open var itemsViewModelsDriver: Driver<[ItemViewModel]> {
        return loadingResultObservable
            .map { [weak self] items in
                self?.viewModels(from: items)
            }
            .flatMap({ element -> Observable<[ItemViewModel]> in
                if let value = element {
                    return .just(value)
                } else {
                    return .empty()
                }
            })
            .share(replay: 1, scope: .forever)
            .asDriver(onErrorDriveWith: .empty())
    }

    open var searchResultsDriver: Driver<[ItemViewModel]> {
        return searchTextRelay.throttle(1, scheduler: MainScheduler.instance)
            .withLatestFrom(loadingResultObservable) { ($0, $1) }
            .flatMapLatest { [weak self] searchText, items -> Observable<ItemsList> in
                self?.search(by: searchText, from: items).asObservable() ?? .empty()
            }
            .map { [weak self] items in
                self?.viewModels(from: items)
            }
            .flatMap({ element -> Observable<[ItemViewModel]> in
                if let value = element {
                    return .just(value)
                } else {
                    return .empty()
                }
            })
            .share(replay: 1, scope: .forever)
            .asDriver(onErrorDriveWith: .empty())
    }

    func viewModel(from item: Item) -> ItemViewModel {
        fatalError("viewModel(from:) has not been implemented")
    }

    func search(by searchString: String, from items: ItemsList) -> Single<ItemsList> {
        fatalError("searchEngine(for:) has not been implemented")
    }

    func bind(searchText: Observable<String>) -> Disposable {
        return searchText.bind(to: searchTextRelay)
    }

    func onDidSelect(item: Item) {
        // override in subclass
    }

    private func viewModels(from items: ItemsList) -> [ItemViewModel] {
        return items.map { self.viewModel(from: $0) }
    }

    var loadingResultObservable: Observable<ResultType> {
        return loadingStateDriver
            .asObservable()
            .map { state -> ResultType? in
                guard case let .result(data, _) = state else {
                    return nil
                }

                return data
            }
            .flatMap({ element -> Observable<ResultType> in
                if let value = element {
                    return .just(value)
                } else {
                    return .empty()
                }
            })
    }

    var loadingErrorObservable: Observable<Error> {
        return loadingStateDriver
            .asObservable()
            .map { state -> Error? in
                guard case let .error(error) = state else {
                    return nil
                }

                return error
            }
            .flatMap({ element -> Observable<Error> in
                if let value = element {
                    return .just(value)
                } else {
                    return .empty()
                }
            })
    }

    var firstLoadingResultObservable: Single<ResultType> {
        return loadingResultObservable
            .take(1)
            .asSingle()
    }
}
