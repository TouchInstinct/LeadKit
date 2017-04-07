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
import UIScrollView_InfiniteScroll

public protocol PaginationTableViewWrapperDelegate: class {

    associatedtype Cursor: ResettableCursorType

    func paginationWrapper(wrapper: PaginationTableViewWrapper<Cursor, Self>,
                           didLoad newItems: [Cursor.Element])

    func paginationWrapper(wrapper: PaginationTableViewWrapper<Cursor, Self>,
                           didReload allItems: [Cursor.Element])

    func emptyPlaceholder(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> UIView

    func errorPlaceholder(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>,
                          forError error: Error) -> UIView

    func initialLoadingIndicator(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> AnyLoadingIndicator

    func loadingMoreIndicator(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> AnyLoadingIndicator

}

public class PaginationTableViewWrapper<C: ResettableCursorType, D: PaginationTableViewWrapperDelegate>
where D.Cursor == C {

    public typealias PlaceholderTransform = (UIView, CGPoint) -> Void

    private let tableView: UITableView
    private let placeholdersContainerView: UIView
    private let paginationViewModel: PaginationViewModel<C>
    private weak var delegate: D?

    public var placeholderTransformOnScroll: PlaceholderTransform = { view, offset in
        var newFrame = view.frame
        newFrame.origin.y = -offset.y

        view.frame = newFrame
    }

    public var scrollObservable: Observable<CGPoint>? {
        didSet {
            scrollObservable?.subscribe(onNext: { [weak self] offset in
                guard let placeholder = self?.currentPlaceholderView else {
                    return
                }

                self?.placeholderTransformOnScroll(placeholder, offset)
            })
            .addDisposableTo(disposeBag)
        }
    }

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

    public init(tableView: UITableView, placeholdersContainer: UIView, cursor: C, delegate: D) {
        self.tableView = tableView
        self.placeholdersContainerView = placeholdersContainer
        self.paginationViewModel = PaginationViewModel(cursor: cursor)
        self.delegate = delegate

        paginationViewModel.state.drive(onNext: { [weak self] state in
            print(state)
            switch state {
            case .initial:
                self?.onInitialState()
            case .loading(let after):
                self?.onLoadingState(afterState: after)
            case .loadingMore(let after):
                self?.onLoadingMoreState(afterState: after)
            case .results(let newItems, let after):
                self?.onResultsState(newItems: newItems, afterState: after)
            case .error(let error, let after):
                self?.onErrorState(error: error, afterState: after)
            case .empty:
                self?.onEmptyState()
            case .exhausted:
                self?.onExhaustedState()
            }
        })
        .addDisposableTo(disposeBag)

        let refreshControl = UIRefreshControl()
        refreshControl.rx.controlEvent(.valueChanged)
            .bindNext { [weak self] in
                self?.reload()
            }
            .addDisposableTo(disposeBag)

        tableView.support.setRefreshControl(refreshControl)
    }

    public func reload() {
        paginationViewModel.load(.reload)
    }

    // MARK: States handling

    private func onInitialState() {
        //
    }

    private func onLoadingState(afterState: PaginationViewModel<C>.State) {
        if case .initial = afterState {
            tableView.isUserInteractionEnabled = false

            currentPlaceholderView?.removeFromSuperview()

            guard let loadingIndicator = delegate?.initialLoadingIndicator(forPaginationWrapper: self) else {
                return
            }

            let loadingIndicatorView = loadingIndicator.view

            loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false

            placeholdersContainerView.insertSubview(loadingIndicatorView, aboveSubview: tableView)

            loadingIndicatorView.centerXAnchor.constraint(equalTo: placeholdersContainerView.centerXAnchor).isActive = true
            loadingIndicatorView.centerYAnchor.constraint(equalTo: placeholdersContainerView.centerYAnchor).isActive = true

            loadingIndicator.startAnimating()

            currentPlaceholderView = loadingIndicatorView
        } else {
            tableView.finishInfiniteScroll()
            tableView.tableFooterView = nil
        }
    }

    private func onLoadingMoreState(afterState: PaginationViewModel<C>.State) {
        if case .error = afterState {
            tableView.tableFooterView = nil
            addInfiniteScroll()
            tableView.beginInfiniteScroll(true)
        }
    }

    private func onResultsState(newItems: [C.Element], afterState: PaginationViewModel<C>.State) {
        tableView.isUserInteractionEnabled = true

        if case .loading = afterState {
            delegate?.paginationWrapper(wrapper: self, didReload: newItems)

            currentPlaceholderView?.removeFromSuperview()

            tableView.support.refreshControl?.endRefreshing()

            addInfiniteScroll()
        } else if case .loadingMore = afterState {
            delegate?.paginationWrapper(wrapper: self, didLoad: newItems)

            tableView.finishInfiniteScroll()
        }
    }

    private func onErrorState(error: Error, afterState: PaginationViewModel<C>.State) {
        if case .loading = afterState {
            enterPlaceholderState()

            guard let errorView = delegate?.errorPlaceholder(forPaginationWrapper: self, forError: error) else {
                return
            }

            preparePlaceholderView(errorView)

            currentPlaceholderView = errorView
        } else if case .loadingMore = afterState {
            tableView.finishInfiniteScroll()

            tableView.removeInfiniteScroll()

            let retryButton = UIButton(type: .custom)
            retryButton.backgroundColor = .lightGray
            retryButton.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
            retryButton.setTitle("Retry load more", for: .normal)
            retryButton.rx.controlEvent(.touchUpInside)
                .bindNext { [weak self] in
                    self?.paginationViewModel.load(.next)
                }
                .addDisposableTo(disposeBag)

            tableView.tableFooterView = retryButton
        }
    }

    private func onEmptyState() {
        enterPlaceholderState()

        guard let emptyView = delegate?.emptyPlaceholder(forPaginationWrapper: self) else {
            return
        }

        preparePlaceholderView(emptyView)

        currentPlaceholderView = emptyView
    }

    // MARK: private stuff

    private func onExhaustedState() {
        tableView.removeInfiniteScroll()
    }

    private func addInfiniteScroll() {
        tableView.addInfiniteScroll { [weak paginationViewModel] _ in
            paginationViewModel?.load(.next)
        }

        tableView.infiniteScrollIndicatorView = delegate?.loadingMoreIndicator(forPaginationWrapper: self).view
    }

    private func enterPlaceholderState() {
        tableView.support.refreshControl?.endRefreshing()
        tableView.isUserInteractionEnabled = true

        currentPlaceholderView?.removeFromSuperview()
    }

    private func preparePlaceholderView(_ placeholderView: UIView) {
        placeholderView.translatesAutoresizingMaskIntoConstraints = false

        placeholdersContainerView.insertSubview(placeholderView, belowSubview: tableView)

        placeholderView.anchorConstrainst(to: placeholdersContainerView).forEach { $0.isActive = true }
    }
}

private extension UIView {

    func anchorConstrainst(to view: UIView) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }

}
