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
import UIScrollView_InfiniteScroll

/// Class that connects PaginationDataLoadingModel with UIScrollView. It handles all non-visual and visual states.
final public class PaginationWrapper<Cursor: ResettableRxDataSourceCursor, Delegate: PaginationWrapperDelegate>
    where Cursor == Delegate.DataSourceType, Cursor.ResultType == [Cursor.Element] {

    private typealias DataLoadingModel = PaginationDataLoadingModel<Cursor>

    private typealias LoadingState = DataLoadingModel.NetworkOperationStateType

    private typealias FinishInfiniteScrollCompletion = ((UIScrollView) -> Void)

    private var wrappedView: AnyPaginationWrappable
    private let paginationViewModel: DataLoadingModel
    private weak var delegate: Delegate?
    private weak var uiDelegate: PaginationWrapperUIDelegate?

    /// Sets the offset between the real end of the scroll view content and the scroll position,
    /// so the handler can be triggered before reaching end. Defaults to 0.0;
    public var infiniteScrollTriggerOffset: CGFloat {
        get {
            return wrappedView.scrollView.infiniteScrollTriggerOffset
        }
        set {
            wrappedView.scrollView.infiniteScrollTriggerOffset = newValue
        }
    }

    public var pullToRefreshEnabled: Bool = true {
        didSet {
            if pullToRefreshEnabled {
                createRefreshControl()
            } else {
                removeRefreshControl()
            }
        }
    }

    private var bottom: CGFloat {
        wrappedView.scrollView.contentSize.height - wrappedView.scrollView.frame.size.height
    }

    private let disposeBag = DisposeBag()

    private var currentPlaceholderView: UIView?
    private var currentPlaceholderViewTopConstraint: NSLayoutConstraint?

    private let applicationCurrentlyActive = BehaviorRelay(value: true)

    /// Initializer with table view, placeholders container view, cusor and delegate parameters.
    ///
    /// - Parameters:
    ///   - wrappedView: UIScrollView instance to work with.
    ///   - cursor: Cursor object that acts as data source.
    ///   - delegate: Delegate object for data loading events handling.
    ///   - uiDelegate: Delegate object for UI customization.
    public init(wrappedView: AnyPaginationWrappable,
                cursor: Cursor,
                delegate: Delegate,
                uiDelegate: PaginationWrapperUIDelegate? = nil) {
        self.wrappedView = wrappedView
        self.delegate = delegate
        self.uiDelegate = uiDelegate

        self.paginationViewModel = PaginationDataLoadingModel(dataSource: cursor) { $0.isEmpty }

        bindViewModelStates()

        createRefreshControl()
    }

    /// Method that reload all data in internal view model.
    public func reload() {
        paginationViewModel.reload()
    }

    /// Method acts like reload, but shows initial loading view after being invoked.
    public func retry() {
        paginationViewModel.retry()
    }

    /// Method that enables placeholders animation due pull-to-refresh interaction.
    ///
    /// - Parameter scrollObservable: Observable that emits content offset as CGPoint.
    public func setScrollObservable(_ scrollObservable: Observable<CGPoint>) {
        scrollObservable
            .asDriver(onErrorJustReturn: .zero)
            .drive(scrollOffsetChanged)
            .disposed(by: disposeBag)
    }

    // MARK: - States handling

    private func onInitialState() {
        //
    }

    private func onLoadingState(afterState: LoadingState) {
        if case .initial = afterState {
            wrappedView.scrollView.isUserInteractionEnabled = false

            removeAllPlaceholderView()

            guard let loadingIndicator = uiDelegate?.initialLoadingIndicator() else {
                return
            }

            let loadingIndicatorView = loadingIndicator.view

            loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = true

            wrappedView.backgroundView = loadingIndicatorView

            loadingIndicator.startAnimating()

            currentPlaceholderView = loadingIndicatorView
        } else {
            removeInfiniteScroll()
            wrappedView.footerView = nil
        }
    }

    private func onLoadingMoreState(afterState: LoadingState) {
        if case .error = afterState { // user tap retry button in table footer
            uiDelegate?.footerRetryViewWillDisappear()
            wrappedView.footerView = nil
            addInfiniteScroll(withHandler: false)
            wrappedView.scrollView.beginInfiniteScroll(true)
        }
    }

    private func onResultsState(newItems: DataLoadingModel.ResultType,
                                from cursor: Cursor,
                                afterState: LoadingState) {

        wrappedView.scrollView.isUserInteractionEnabled = true

        if case .initialLoading = afterState {
            delegate?.paginationWrapper(didReload: newItems, using: cursor)

            removeAllPlaceholderView()

            wrappedView.scrollView.support.refreshControl?.endRefreshing()

            addInfiniteScroll(withHandler: true)
        } else if case .loadingMore = afterState {
            delegate?.paginationWrapper(didLoad: newItems, using: cursor)

            removeAllPlaceholderView()
            addInfiniteScrollWithHandler()
        }
    }

    private func onErrorState(error: Error, afterState: LoadingState) {
        if case .initialLoading = afterState {
            defer {
                wrappedView.scrollView.support.refreshControl?.endRefreshing()
            }

            delegate?.clearData()

            let customErrorHandling = uiDelegate?.customInitialLoadingErrorHandling(for: error) ?? false
            guard !customErrorHandling, let errorView = uiDelegate?.errorPlaceholder(for: error) else {
                return
            }

            replacePlaceholderViewIfNeeded(with: errorView)
        } else {
            guard let retryView = uiDelegate?.footerRetryView(),
                let retryViewHeight = uiDelegate?.footerRetryViewHeight() else {
                    removeInfiniteScroll()
                    return
            }

            retryView.frame = CGRect(x: 0, y: 0, width: wrappedView.scrollView.bounds.width, height: retryViewHeight)
            retryView.button.addTarget(self, action: #selector(retryEvent), for: .touchUpInside)

            uiDelegate?.footerRetryViewWillAppear()

            removeInfiniteScroll { scrollView in
                self.wrappedView.footerView = retryView

                let shouldUpdateContentOffset = Int(scrollView.contentOffset.y + retryViewHeight) >= Int(self.bottom)

                if shouldUpdateContentOffset {
                    let newContentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y + retryViewHeight)
                    scrollView.setContentOffset(newContentOffset, animated: true)

                    if #available(iOS 13, *) {
                        scrollView.setContentOffset(newContentOffset, animated: true)
                    }
                }
            }
        }
    }

    @objc private func retryEvent() {
        paginationViewModel.loadMore()
    }

    private func onEmptyState() {
        defer {
            wrappedView.scrollView.support.refreshControl?.endRefreshing()
        }

        delegate?.clearData()

        guard let emptyView = uiDelegate?.emptyPlaceholder() else {
            return
        }

        replacePlaceholderViewIfNeeded(with: emptyView)
    }

    private func replacePlaceholderViewIfNeeded(with placeholderView: UIView) {
        wrappedView.scrollView.isUserInteractionEnabled = true
        removeAllPlaceholderView()

        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.isHidden = false

        // I was unable to add pull-to-refresh placeholder scroll behaviour without this trick
        let placeholderWrapperView = UIView()
        placeholderWrapperView.addSubview(placeholderView)

        let leadingConstraint = placeholderView.leadingAnchor.constraint(equalTo: placeholderWrapperView.leadingAnchor)
        let trailingConstraint = placeholderView.trailingAnchor.constraint(equalTo: placeholderWrapperView.trailingAnchor)
        let topConstraint = placeholderView.topAnchor.constraint(equalTo: placeholderWrapperView.topAnchor)
        let bottomConstraint = placeholderView.bottomAnchor.constraint(equalTo: placeholderWrapperView.bottomAnchor)

        NSLayoutConstraint.activate([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            bottomConstraint
        ])

        currentPlaceholderViewTopConstraint = topConstraint

        wrappedView.backgroundView = placeholderWrapperView

        currentPlaceholderView = placeholderView
    }

    // MARK: - private stuff

    private func onExhaustedState() {
        removeInfiniteScroll()
        removeAllPlaceholderView()
    }

    private func addInfiniteScrollWithHandler() {
        removeInfiniteScroll()
        addInfiniteScroll(withHandler: true)
    }

    private func addInfiniteScroll(withHandler: Bool) {
        if withHandler {
            wrappedView.scrollView.addInfiniteScroll { [weak paginationViewModel] _ in
                paginationViewModel?.loadMore()
            }
        } else {
            wrappedView.scrollView.addInfiniteScroll { _ in }
        }

        wrappedView.scrollView.infiniteScrollIndicatorView = uiDelegate?.loadingMoreIndicator()?.view
    }

    private func removeInfiniteScroll(with completion: FinishInfiniteScrollCompletion? = nil) {
        wrappedView.scrollView.finishInfiniteScroll(completion: completion)
        wrappedView.scrollView.removeInfiniteScroll()
    }

    private func createRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)

        wrappedView.scrollView.support.setRefreshControl(refreshControl)
    }

    @objc private func refreshAction() {
        // it is implemented the combined behavior of `touchUpInside` and `touchUpOutside` using `CFRunLoopPerformBlock`,
        // which `UIRefreshControl` does not support
        CFRunLoopPerformBlock(CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue) { [weak self] in
            self?.reload()
        }
    }

    private func removeRefreshControl() {
        wrappedView.scrollView.support.setRefreshControl(nil)
    }

    private func bindViewModelStates() {
        paginationViewModel.stateDriver
            .drive(stateChanged)
            .disposed(by: disposeBag)
    }

    private func removeAllPlaceholderView() {
        wrappedView.backgroundView = nil
        wrappedView.footerView = nil
    }
}

private extension PaginationWrapper {

    private var stateChanged: Binder<LoadingState> {
        return Binder(self) { base, value in
            switch value {
            case .initial:
                base.onInitialState()

            case let .initialLoading(after):
                base.onLoadingState(afterState: after)

            case let .loadingMore(after):
                base.onLoadingMoreState(afterState: after)

            case let .results(newItems, from, after):
                base.onResultsState(newItems: newItems, from: from, afterState: after)

            case let .error(error, after):
                base.onErrorState(error: error, afterState: after)

            case .empty:
                base.onEmptyState()

            case .exhausted:
                base.onExhaustedState()
            }
        }
    }

    var scrollOffsetChanged: Binder<CGPoint> {
        return Binder(self) { base, value in
            base.currentPlaceholderViewTopConstraint?.constant = -value.y
        }
    }
}
