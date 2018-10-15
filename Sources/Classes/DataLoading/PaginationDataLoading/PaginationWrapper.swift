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

    private let disposeBag = DisposeBag()

    private var currentPlaceholderView: UIView?
    private var currentPlaceholderViewTopConstraint: NSLayoutConstraint?

    private let applicationCurrentyActive = BehaviorRelay(value: true)

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

        bindAppStateNotifications()
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

            removeCurrentPlaceholderView()

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
            uiDelegate?.footerRetryButtonWillDisappear()
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

            removeCurrentPlaceholderView()

            wrappedView.scrollView.support.refreshControl?.endRefreshing()

            addInfiniteScroll(withHandler: true)
        } else if case .loadingMore = afterState {
            delegate?.paginationWrapper(didLoad: newItems, using: cursor)

            readdInfiniteScrollWithHandler()
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
        } else if case .loadingMore = afterState {
            guard let retryButton = uiDelegate?.footerRetryButton(),
                let retryButtonHeight = uiDelegate?.footerRetryButtonHeight() else {

                    removeInfiniteScroll()

                    return
            }

            retryButton.frame = CGRect(x: 0, y: 0, width: wrappedView.scrollView.bounds.width, height: retryButtonHeight)

            retryButton.rx
                .controlEvent(.touchUpInside)
                .asDriver()
                .drive(retryEvent)
                .disposed(by: disposeBag)

            uiDelegate?.footerRetryButtonWillAppear()

            removeInfiniteScroll { scrollView in
                self.wrappedView.footerView = retryButton

                let newContentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y + retryButtonHeight)

                scrollView.setContentOffset(newContentOffset, animated: true)
            }
        }
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
        removeCurrentPlaceholderView()

        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.isHidden = false

        // I was unable to add pull-to-refresh placeholder scroll behaviour without this trick
        let placeholderWrapperView = UIView()
        placeholderWrapperView.addSubview(placeholderView)

        let leadingConstraint = placeholderView.leadingAnchor.constraint(equalTo: placeholderWrapperView.leadingAnchor)
        let trailingConstraint = placeholderView.trailingAnchor.constraint(equalTo: placeholderWrapperView.trailingAnchor)
        let topConstraint = placeholderView.topAnchor.constraint(equalTo: placeholderWrapperView.topAnchor)
        let bottomConstraint = placeholderView.bottomAnchor.constraint(equalTo: placeholderWrapperView.bottomAnchor)

        NSLayoutConstraint.activate([leadingConstraint,
                                     trailingConstraint,
                                     topConstraint,
                                     bottomConstraint])

        currentPlaceholderViewTopConstraint = topConstraint

        wrappedView.backgroundView = placeholderWrapperView

        currentPlaceholderView = placeholderView
    }

    // MARK: - private stuff

    private func onExhaustedState() {
        removeInfiniteScroll()
    }

    private func readdInfiniteScrollWithHandler() {
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
        refreshControl.rx
            .controlEvent(.valueChanged)
            .asDriver()
            .drive(reloadEvent)
            .disposed(by: disposeBag)

        wrappedView.scrollView.support.setRefreshControl(refreshControl)
    }

    private func removeRefreshControl() {
        wrappedView.scrollView.support.setRefreshControl(nil)
    }

    private func bindViewModelStates() {
        paginationViewModel.stateDriver
            .flatMap { [applicationCurrentyActive] state -> Driver<LoadingState> in
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
            .drive(stateChanged)
            .disposed(by: disposeBag)
    }

    private func removeCurrentPlaceholderView() {
        wrappedView.backgroundView = nil
    }

    private func bindAppStateNotifications() {
        let notificationCenter = NotificationCenter.default.rx

        notificationCenter.notification(UIApplication.willResignActiveNotification)
            .map { _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(applicationCurrentyActive)
            .disposed(by: disposeBag)

        notificationCenter.notification(UIApplication.didBecomeActiveNotification)
            .map { _ in true }
            .asDriver(onErrorJustReturn: true)
            .drive(applicationCurrentyActive)
            .disposed(by: disposeBag)
    }

}

private extension PaginationWrapper {

    private var stateChanged: Binder<LoadingState> {
        return Binder(self) { base, value in
            switch value {
            case .initial:
                base.onInitialState()
            case .initialLoading(let after):
                base.onLoadingState(afterState: after)
            case .loadingMore(let after):
                base.onLoadingMoreState(afterState: after)
            case .results(let newItems, let from, let after):
                base.onResultsState(newItems: newItems, from: from, afterState: after)
            case .error(let error, let after):
                base.onErrorState(error: error, afterState: after)
            case .empty:
                base.onEmptyState()
            case .exhausted:
                base.onExhaustedState()
            }
        }
    }

    var retryEvent: Binder<Void> {
        return Binder(self) { base, _ in
            base.paginationViewModel.loadMore()
        }
    }

    var reloadEvent: Binder<Void> {
        return Binder(self) { base, _ in
            base.reload()
        }
    }

    var scrollOffsetChanged: Binder<CGPoint> {
        return Binder(self) { base, value in
            base.currentPlaceholderViewTopConstraint?.constant = -value.y
        }
    }

}
