//
//  Copyright (c) 2020 Touch Instinct
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
import Cursors
import TISwiftUtils

/// Class that connects PaginationDataLoadingModel with UIScrollView. It handles all non-visual and visual states.
final public class Paginator<Cursor: PaginatorCursorType,
                             Delegate: PaginatorDelegate,
                             UIDelegate: PaginatorUIDelegate>
where Cursor.Page == Delegate.Page, UIDelegate.ErrorType == Cursor.Failure {
    

    private typealias State = PaginatorState<Cursor>
    private typealias FinishInfiniteScrollCompletion = ParameterClosure<UIScrollView>

    private let dataLoadingModel: PaginatorDataLoadingModel<Cursor>

    private weak var delegate: Delegate?
    private weak var infiniteScrollDelegate: InfiniteScrollDelegate?
    private weak var uiDelegate: UIDelegate?
    
    /// Initializer with table cursor, data delegate and UI delegates.
    ///
    /// - Parameters:
    ///   - cursor: Cursor object that acts as data source.
    ///   - delegate: Delegate object for data loading events handling.
    ///   - infiniteScrollDelegate: Delegate object for handling infinite scroll.
    ///   - uiDelegate: Delegate object for UI customization.
    public init(cursor: Cursor,
                delegate: Delegate,
                infiniteScrollDelegate: InfiniteScrollDelegate,
                uiDelegate: UIDelegate?) {
        
        self.delegate = delegate
        self.infiniteScrollDelegate = infiniteScrollDelegate
        self.uiDelegate = uiDelegate

        self.dataLoadingModel = PaginatorDataLoadingModel(cursor: cursor)

        bindToDataLoadingModel()
    }

    /// Method that reloads all data in internal view model.
    public func reload() {
        dataLoadingModel.reload()
    }

    /// Retry loading depending on previous error state.
    public func retry() {
        
        switch dataLoadingModel.state {
        case .loadingError, .empty:
            dataLoadingModel.reload()
        case .loadingMoreError:
            dataLoadingModel.loadMore()
        default:
            assertionFailure("Retry was used without any error.")
        }
    }

    /// Add Infinite scroll to footer of tableView
    public func addInfiniteScroll(withHandler: Bool) {
        if withHandler {
            infiniteScrollDelegate?.addInfiniteScroll { [weak dataLoadingModel] _ in
                dataLoadingModel?.loadMore()
            }
        } else {
            infiniteScrollDelegate?.addInfiniteScroll { _ in }
        }
        
        uiDelegate?.onAddInfiniteScroll()
    }

    // MARK: - State handling

    private func onStateChanged(from old: State, to new: State) {
        
        switch new {
        case .loading:
            onLoadingState(afterState: old)

        case let .loadingError(error):
            onErrorState(error: error, afterState: old)

        case .loadingMore:
            onLoadingMoreState(afterState: old)

        case let .content(page):
            onContentState(newPage: page, afterState: old)

        case let .loadingMoreError(error):
            onErrorState(error: error, afterState: old)

        case .empty:
            onEmptyState()
            
        case .exhausted:
            onExhaustedState()
        }
    }
    
    private func onLoadingState(afterState: State) {
        
        if dataLoadingModel.isInitialState(afterState) {
            uiDelegate?.onInitialLoading()
        } else {
            removeInfiniteScroll()
            uiDelegate?.onReloading()
        }
    }

    private func onLoadingMoreState(afterState: State) {
        uiDelegate?.onLoadingMore()
        
        if case .loadingMoreError = afterState {
            addInfiniteScroll(withHandler: false)
            infiniteScrollDelegate?.beginInfiniteScroll(true)
        }
    }

    private func onContentState(newPage: Cursor.Page,
                                afterState: State) {

        uiDelegate?.onSuccessfulLoad()
        
        switch afterState {
        case .loading:
            delegate?.paginator(didReloadWith: newPage)
            addInfiniteScroll(withHandler: true)
            
        case .loadingMore:
            delegate?.paginator(didLoad: newPage)
            readdInfiniteScrollWithHandler()
            
        default:
            assertionFailure("Content arrived without loading first.")
        }
    }

    private func onErrorState(error: Cursor.Failure, afterState: State) {
        
        switch afterState {
        case .loading:
            uiDelegate?.onLoadingError(error)
            
        case .loadingMore:
            removeInfiniteScroll()
            uiDelegate?.onLoadingMoreError(error)
            
        default:
            assertionFailure("Error happened without loading.")
        }
    }

    private func onEmptyState() {
        delegate?.clearContent()
        uiDelegate?.onEmptyState()
    }
    
    private func onExhaustedState() {
        removeInfiniteScroll()
        uiDelegate?.onExhaustedState()
    }
    
    private func bindToDataLoadingModel() {
        dataLoadingModel.onStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.onStateChanged(from: state.old, to: state.new)
            }
        }
    }
    
    // MARK: - InfiniteScroll management

    private func readdInfiniteScrollWithHandler() {
        removeInfiniteScroll()
        addInfiniteScroll(withHandler: true)
    }

    private func removeInfiniteScroll(with completion: FinishInfiniteScrollCompletion? = nil) {
        infiniteScrollDelegate?.finishInfiniteScroll(completion: completion)
        infiniteScrollDelegate?.removeInfiniteScroll()
    }
}
