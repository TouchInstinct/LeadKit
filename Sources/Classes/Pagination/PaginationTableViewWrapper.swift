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

import UIKit
import RxSwift
import RxCocoa
import UIScrollView_InfiniteScroll

/// PaginationTableViewWrapper delegate used for pagination results handling and
/// customization of bound states (loading, empty, error, etc.).
public protocol PaginationTableViewWrapperDelegate: class {

    associatedtype Cursor: ResettableCursorType

    /// Delegate method that handles loading new chunk of data.
    ///
    /// - Parameters:
    ///   - wrapper: Wrapper object that loaded new items.
    ///   - newItems: New items.
    ///   - cursor: Cursor used to load items
    func paginationWrapper(wrapper: PaginationTableViewWrapper<Cursor, Self>,
                           didLoad newItems: [Cursor.Element],
                           usingCursor cursor: Cursor)

    /// Delegate method that handles reloading or initial loading of data.
    ///
    /// - Parameters:
    ///   - wrapper: Wrapper object that reload items.
    ///   - allItems: New items.
    ///   - cursor: Cursor used to load items
    func paginationWrapper(wrapper: PaginationTableViewWrapper<Cursor, Self>,
                           didReload allItems: [Cursor.Element],
                           usingCursor cursor: Cursor)

    /// Delegate method that returns placeholder view for empty state.
    ///
    /// - Parameter wrapper: Wrapper object that requests empty placeholder view.
    /// - Returns: Configured instace of UIView.
    func emptyPlaceholder(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> UIView

    /// Delegate method that returns placeholder view for error state.
    ///
    /// - Parameters:
    ///   - wrapper: Wrapper object that requests error placeholder view.
    ///   - error: Error that occured due data loading.
    /// - Returns: Configured instace of UIView.
    func errorPlaceholder(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>,
                          forError error: Error) -> UIView

    /// Delegate method that returns loading idicator for initial loading state.
    /// This indicator will appear at center of the placeholders container.
    ///
    /// - Parameter wrapper: Wrapper object that requests loading indicator
    /// - Returns: Configured instace of AnyLoadingIndicator.
    func initialLoadingIndicator(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> AnyLoadingIndicator

    /// Delegate method that returns loading idicator for initial loading state.
    ///
    /// - Parameter wrapper: Wrapper object that requests loading indicator.
    /// - Returns: Configured instace of AnyLoadingIndicator.
    func loadingMoreIndicator(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> AnyLoadingIndicator

    /// Delegate method that returns instance of UIButton for "retry load more" action.
    ///
    /// - Parameter wrapper: Wrapper object that requests button for "retry load more" action.
    /// - Returns: Configured instace of AnyLoadingIndicator.
    func retryLoadMoreButton(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> UIButton

    /// Delegate method that returns preferred height for "retry load more" button.
    ///
    /// - Parameter wrapper: Wrapper object that requests height "retry load more" button.
    /// - Returns: Preferred height of "retry load more" button.
    func retryLoadMoreButtonHeight(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> CGFloat

    // Delegate method, used to clear tableView if placeholder is shown.
    func clearTableView()
}

/// Class that connects PaginationViewModel with UITableView. It handles all non-visual and visual states.
final public class PaginationTableViewWrapper<Cursor: ResettableCursorType, Delegate: PaginationTableViewWrapperDelegate>
where Delegate.Cursor == Cursor {

    private let tableView: UITableView
    private let paginationViewModel: PaginationViewModel<Cursor>
    private weak var delegate: Delegate?

    /// Sets the offset between the real end of the scroll view content and the scroll position,
    /// so the handler can be triggered before reaching end. Defaults to 0.0;
    public var infiniteScrollTriggerOffset: CGFloat {
        get {
            return tableView.infiniteScrollTriggerOffset
        }
        set {
            tableView.infiniteScrollTriggerOffset = newValue
        }
    }

    private let disposeBag = DisposeBag()

    private var currentPlaceholderView: UIView?
    private var currentPlaceholderViewTopConstraint: NSLayoutConstraint?

    private let applicationCurrentyActive = Variable<Bool>(true)

    /// Initializer with table view, placeholders container view, cusor and delegate parameters.
    ///
    /// - Parameters:
    ///   - tableView: UITableView instance to work with.
    ///   - cursor: Cursor object that acts as data source.
    ///   - delegate: Delegate object for data loading events handling and UI customization.
    ///   - allowEmptyResults: If true - do not show empty placeholder, pass empty results.
    public init(tableView: UITableView, cursor: Cursor, delegate: Delegate, allowEmptyResults: Bool = false) {
        self.tableView = tableView
        self.paginationViewModel = PaginationViewModel(cursor: cursor, allowEmptyResults: allowEmptyResults)
        self.delegate = delegate

        bindViewModelStates()

        createRefreshControl()

        bindAppStateNotifications()
    }

    /// Method that reload all data in internal view model.
    public func reload() {
        paginationViewModel.load(.reload)
    }

    /// Method acts like reload, but shows initial loading view after being invoked.
    public func retry() {
        paginationViewModel.load(.retry)
    }

    /// Method that enables placeholders animation due pull-to-refresh interaction.
    ///
    /// - Parameter scrollObservable: Observable that emits content offset as CGPoint.
    public func setScrollObservable(_ scrollObservable: Observable<CGPoint>) {
        scrollObservable.subscribe(onNext: { [weak self] offset in
            self?.currentPlaceholderViewTopConstraint?.constant = -offset.y
        })
        .addDisposableTo(disposeBag)
    }

    // MARK: - States handling

    private func onInitialState() {
        //
    }

    private func onLoadingState(afterState: PaginationViewModel<Cursor>.State) {
        if case .initial = afterState {
            tableView.isUserInteractionEnabled = false

            removeCurrentPlaceholderView()

            guard let loadingIndicator = delegate?.initialLoadingIndicator(forPaginationWrapper: self) else {
                return
            }

            let loadingIndicatorView = loadingIndicator.view

            loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = true

            tableView.backgroundView = loadingIndicatorView

            loadingIndicator.startAnimating()

            currentPlaceholderView = loadingIndicatorView
        } else {
            removeInfiniteScroll()
            tableView.tableFooterView = nil
        }
    }

    private func onLoadingMoreState(afterState: PaginationViewModel<Cursor>.State) {
        if case .error = afterState { // user tap retry button in table footer
            tableView.tableFooterView = nil
            addInfiniteScroll()
            tableView.beginInfiniteScroll(true)
        }
    }

    private func onResultsState(newItems: [Cursor.Element],
                                inCursor cursor: Cursor,
                                afterState: PaginationViewModel<Cursor>.State) {

        tableView.isUserInteractionEnabled = true

        if case .loading = afterState {
            delegate?.paginationWrapper(wrapper: self, didReload: newItems, usingCursor: cursor)

            removeCurrentPlaceholderView()

            tableView.support.refreshControl?.endRefreshing()

            if !cursor.exhausted {
                addInfiniteScroll()
            }
        } else if case .loadingMore = afterState {
            delegate?.paginationWrapper(wrapper: self, didLoad: newItems, usingCursor: cursor)

            tableView.finishInfiniteScroll()
        }
    }

    private func onErrorState(error: Error, afterState: PaginationViewModel<Cursor>.State) {
        if case .loading = afterState {
            defer {
                tableView.support.refreshControl?.endRefreshing()
            }

            guard let errorView = delegate?.errorPlaceholder(forPaginationWrapper: self, forError: error) else {
                return
            }

            replacePlaceholderViewIfNeeded(with: errorView)
        } else if case .loadingMore = afterState {
            removeInfiniteScroll()

            guard let retryButton = delegate?.retryLoadMoreButton(forPaginationWrapper: self),
                let retryButtonHeigth = delegate?.retryLoadMoreButtonHeight(forPaginationWrapper: self) else {
                    return
            }

            retryButton.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: retryButtonHeigth)

            retryButton.rx.controlEvent(.touchUpInside)
                .bind { [weak self] in
                    self?.paginationViewModel.load(.next)
                }
                .addDisposableTo(disposeBag)

            tableView.tableFooterView = retryButton
        }
    }

    private func onEmptyState() {
        defer {
            tableView.support.refreshControl?.endRefreshing()
        }
        guard let emptyView = delegate?.emptyPlaceholder(forPaginationWrapper: self) else {
            return
        }
        replacePlaceholderViewIfNeeded(with: emptyView)
    }

    private func replacePlaceholderViewIfNeeded(with placeholderView: UIView) {
        tableView.isUserInteractionEnabled = true
        removeCurrentPlaceholderView()

        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.isHidden = false

        // I was unable to add pull-to-refresh placeholder scroll behaviour without this trick
        let wrapperView = UIView()
        wrapperView.addSubview(placeholderView)

        let leadingConstraint = placeholderView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor)
        let trailingConstraint = placeholderView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor)
        let topConstraint = placeholderView.topAnchor.constraint(equalTo: wrapperView.topAnchor)
        let bottomConstraint = placeholderView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)

        wrapperView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])

        currentPlaceholderViewTopConstraint = topConstraint

        tableView.backgroundView = wrapperView

        currentPlaceholderView = placeholderView
    }

    // MARK: - private stuff

    private func onExhaustedState() {
        removeInfiniteScroll()
    }

    private func addInfiniteScroll() {
        tableView.addInfiniteScroll { [weak paginationViewModel] _ in
            paginationViewModel?.load(.next)
        }

        tableView.infiniteScrollIndicatorView = delegate?.loadingMoreIndicator(forPaginationWrapper: self).view
    }

    private func removeInfiniteScroll() {
        tableView.finishInfiniteScroll()
        tableView.removeInfiniteScroll()
    }

    private func createRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.rx.controlEvent(.valueChanged)
            .bind { [weak self] in
                self?.reload()
            }
            .addDisposableTo(disposeBag)

        tableView.support.setRefreshControl(refreshControl)
    }

    private func bindViewModelStates() {
        typealias State = PaginationViewModel<Cursor>.State

        paginationViewModel.state.flatMap { [applicationCurrentyActive] state -> Driver<State> in
            if applicationCurrentyActive.value {
                return .just(state)
            } else {
                return applicationCurrentyActive
                    .asObservable()
                    .filter { $0 }
                    .delay(0.5, scheduler: MainScheduler.instance)
                    .asDriver(onErrorJustReturn: true)
                    .map { _ in state }
            }
        }
        .drive(onNext: { [weak self] state in
            switch state {
            case .initial:
                self?.onInitialState()
            case .loading(let after):
                self?.onLoadingState(afterState: after)
            case .loadingMore(let after):
                self?.onLoadingMoreState(afterState: after)
            case .results(let newItems, let cursor, let after):
                self?.onResultsState(newItems: newItems, inCursor: cursor, afterState: after)
            case .error(let error, let after):
                self?.delegate?.clearTableView()
                self?.onErrorState(error: error, afterState: after)
            case .empty:
                self?.delegate?.clearTableView()
                self?.onEmptyState()
            case .exhausted:
                self?.onExhaustedState()
            }
        })
        .addDisposableTo(disposeBag)
    }

    private func removeCurrentPlaceholderView() {
        tableView.backgroundView = nil
    }

    private func bindAppStateNotifications() {
        let notificationCenter = NotificationCenter.default.rx

        notificationCenter.notification(.UIApplicationWillResignActive)
            .subscribe(onNext: { [weak self] _ in
                self?.applicationCurrentyActive.value = false
            })
            .addDisposableTo(disposeBag)

        notificationCenter.notification(.UIApplicationDidBecomeActive)
            .subscribe(onNext: { [weak self] _ in
                self?.applicationCurrentyActive.value = true
            })
            .addDisposableTo(disposeBag)
    }

}
