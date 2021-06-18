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

import TableKit
import RxSwift
import UIKit

public typealias SearchResultsController = UIViewController & SearchResultsViewController

/// Class that allows to enter text for search and then displays search results in table view
open class BaseSearchViewController < Item,
    ItemViewModel,
    ViewModel,
    CustomView: UIView & TableViewHolder>: BaseCustomViewController<ViewModel, CustomView>
where ViewModel: BaseSearchViewModel<Item, ItemViewModel> {

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private let searchResultsController: SearchResultsController
    private let searchController: UISearchController
    private var didEnterText = false

    // MARK: - Initialization

    public init(viewModel: ViewModel, searchResultsController: SearchResultsController) {
        self.searchResultsController = searchResultsController
        self.searchController = UISearchController(searchResultsController: searchResultsController)
        super.init(viewModel: viewModel)
        initialLoadView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configurable Controller

    open override func bindViews() {
        super.bindViews()
        viewModel.itemsViewModelsDriver
            .drive(with: self) { base, viewModels in
                base.handle(itemViewModels: viewModels)
            }
            .disposed(by: disposeBag)

        Observable.merge(searchResults, resetResults)
            .subscribe(with: self) { base, state in
                base.handle(searchResultsState: state)
            }
            .disposed(by: disposeBag)

        let searchText = searchController.searchBar.rx.text
            .changed
            .do(onNext: { [weak self] text in
                self?.handle(searchText: text)
            })
            .map { $0 ?? "" }

        viewModel.bind(searchText: searchText)
            .disposed(by: disposeBag)
    }

    open override func addViews() {
        super.addViews()

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            customView.tableView.tableHeaderView = searchController.searchBar
        }
        searchController.view.addSubview(statusBarView)
    }

    open override func configureAppearance() {
        super.configureAppearance()
        definesPresentationContext = true
        configureSearchBarAppearance(searchController.searchBar)
        customView.tableView.tableHeaderView?.backgroundColor = searchBarColor
    }

    open override func localize() {
        super.localize()

        searchController.searchBar.placeholder = searchBarPlaceholder
    }

    // MARK: - Search Controller Functionality

    open func createRows(from itemsViewModels: [ItemViewModel]) -> [Row] {
        assertionFailure("createRows(from:) has not been implemented")
        return []
    }

    open var searchBarPlaceholder: String {
        ""
    }

    open var searchBarColor: UIColor {
        .gray
    }

    open var statusBarView: UIView {
        let statusBarSize = statusBarFrame().size
        let statusBarView = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: statusBarSize.width,
                                                 height: statusBarSize.height))
        statusBarView.backgroundColor = statusBarColor

        return statusBarView
    }

    open var statusBarColor: UIColor {
        .black
    }

    open func updateContent(with viewModels: [ItemViewModel]) {
        // override in subclass
    }

    open func stateForUpdate(with viewModels: [ItemViewModel]) -> SearchResultsViewControllerState {
        let rows = createRows(from: viewModels)
        return .rowsContent(rows: rows)
    }

    open var resetResults: Observable<SearchResultsViewControllerState> {
        searchController.rx.willPresent
            .map { SearchResultsViewControllerState.initial }
    }

    open var searchResults: Observable<SearchResultsViewControllerState> {
        viewModel.searchResultsDriver
            .asObservable()
            .compactMap { [weak self] viewModels -> SearchResultsViewControllerState? in
                self?.stateForUpdate(with: viewModels)
            }
    }

    // MARK: - Helpers

    open func handle(itemViewModels viewModels: [ItemViewModel]) {
        updateContent(with: viewModels)
    }

    open func handle(searchResultsState state: SearchResultsViewControllerState) {
        searchResultsController.update(for: state)
    }

    open func handle(searchText: String?) {
        setTableViewInsets()
    }

    private func setTableViewInsets() {
        guard !didEnterText else {
            return
        }
        didEnterText = true
        searchResultsController.searchResultsView.tableView.contentInset = tableViewInsets
        searchResultsController.searchResultsView.tableView.scrollIndicatorInsets = tableViewInsets
    }

    open func statusBarFrame() -> CGRect {
        /// override in subclass
        return .zero
    }

    open func configureSearchBarAppearance(_ searchBar: UISearchBar) {
        // override in subclass
    }
}

extension BaseSearchViewController {
    open var tableViewInsets: UIEdgeInsets {
        let searchBarHeight = searchController.searchBar.frame.height
        let statusBarHeight = statusBarFrame().height

        return UIEdgeInsets(top: searchBarHeight + statusBarHeight,
                            left: 0,
                            bottom: 0,
                            right: 0)
    }
}
