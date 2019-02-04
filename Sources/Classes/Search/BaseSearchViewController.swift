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

open class BaseSearchViewController<Item,
    ItemViewModel,
    ViewModel,
    ResultsVC: SearchResultsViewController,
    CustomView>: UIViewController, ConfigurableController
where ViewModel: BaseSearchViewModel<Item, ItemViewModel>, CustomView: UIView, CustomView: TableViewHolder {

    // MARK: - Properties
    public let viewModel: ViewModel

    private let disposeBag = DisposeBag()
    let customView = CustomView()
    private let searchResultsViewController = ResultsVC()
    private lazy var searchController = UISearchController(searchResultsController: searchResultsViewController)
    private var didEnterText = false

    // MARK: - Initialization

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    open override func loadView() {
        view = customView
    }

    // MARK: - Configurable Controller

    public func configureBarButtons() {
        // override in subclass
    }

    public func bindViews() {
        viewModel.itemsViewModelsDriver
            .drive(onNext: { [weak self] viewModels in
                self?.handle(itemViewModels: viewModels)
            })
            .disposed(by: disposeBag)

        Observable.merge(searchResults, resetResults)
            .subscribe(onNext: { [weak self] state in
                self?.handle(searchResultsState: state)
            })
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

    public func addViews() {
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            customView.tableView.tableHeaderView = searchController.searchBar
        }
        searchController.view.addSubview(statusBarView)
    }

    public func configureAppearance() {
        definesPresentationContext = true
        customView.tableView.tableHeaderView?.backgroundColor = searchBarColor
    }

    public func localize() {
        searchController.searchBar.placeholder = searchBarPlaceholder
    }

    // MARK: - Search Controller Functionality

    func createRows(from itemsViewModels: [ItemViewModel]) -> [Row] {
        fatalError("createRows(from:) has not been implemented")
    }

    var searchBarPlaceholder: String {
        return ""
    }

    var searchBarColor: UIColor {
        return .gray
    }

    var statusBarView: UIView {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarView = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: statusBarSize.width,
                                                 height: statusBarSize.height))
        statusBarView.backgroundColor = statusBarColor

        return statusBarView
    }

    var statusBarColor: UIColor {
        return .black
    }

    func updateContent(with viewModels: [ItemViewModel]) {
        // override in subclass
    }

    func stateForUpdate(with viewModels: [ItemViewModel]) -> SearchResultsViewControllerState {
        let rows = createRows(from: viewModels)
        return .rowsContent(rows: rows)
    }

    var resetResults: Observable<SearchResultsViewControllerState> {
        return searchController.rx.willPresent
            .map { SearchResultsViewControllerState.initial }
    }

    var searchResults: Observable<SearchResultsViewControllerState> {
        return viewModel.searchResultsDriver
            .asObservable()
            .map { [weak self] viewModels -> SearchResultsViewControllerState in
                self?.stateForUpdate(with: viewModels) ?? .rowsContent(rows: [])
            }
    }

    // MARK: - Helpers

    func handle(itemViewModels viewModels: [ItemViewModel]) {
        updateContent(with: viewModels)
    }

    func handle(searchResultsState state: SearchResultsViewControllerState) {
        searchResultsViewController.update(from: state)
    }

    func handle(searchText: String?) {
        setTableViewInsets()
    }

    private func setTableViewInsets() {
        if !didEnterText {
            didEnterText = true
            searchResultsViewController.resultsView?.tableView.contentInset = tableViewInsets
            searchResultsViewController.resultsView?.tableView.scrollIndicatorInsets = tableViewInsets
        }
    }
}

extension BaseSearchViewController {
    var tableViewInsets: UIEdgeInsets {
        let searchBarHeight = searchController.searchBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        return UIEdgeInsets(top: searchBarHeight + statusBarHeight,
                            left: 0,
                            bottom: 0,
                            right: 0)
    }
}
