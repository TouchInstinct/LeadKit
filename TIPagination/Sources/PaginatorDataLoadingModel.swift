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

import Cursors
import TISwiftUtils

open class PaginatorDataLoadingModel<Cursor: PaginatorCursorType> {
    
    public typealias State = PaginatorState<Cursor>
        
    // MARK: - Public Properties
    
    private var cursor: Cursor
    
    private(set) var state: PaginatorState<Cursor> {
        didSet {
            onStateChanged?((old: oldValue, new: state))
        }
    }
    
    /// Handler for observing state changes
    var onStateChanged: ParameterClosure<(old: State, new: State)>?
    
    // MARK: - Public Initializers
    
    init(cursor: Cursor) {
        self.cursor = cursor
        state = .loading
    }
    
    // MARK: - Public Methods

    /// First data loading or reloading
    open func reload() {
        state = .loading
        cursor = cursor.reset()
        commonLoad()
    }

    /// Load more content
    open func loadMore() {
        state = .loadingMore
        commonLoad()
    }
    
    public func isInitialState(_ state: State) -> Bool {
        if case .loading = state {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Private Methods
    
    private func commonLoad() {
        
        cursor.cancel()
        cursor.loadNextPage { [weak self] in
            switch $0 {
            case let .success(response):
                self?.onSuccess(response)
            case let .failure(error):
                self?.onGot(error: error)
            }
        }
    }
    
    open func onSuccess(_ response: Cursor.SuccessResult) {
        
        switch state {
        case .loading where response.page.isEmptyPage:
            state = .empty
        default:
            state = .content(response.page)
            
            if response.exhausted {
                state = .exhausted
            }
        }
    }

    open func onGot(error: Cursor.Failure) {
        
        guard !error.isExhausted else {
            state = .exhausted
            return
        }
            
        switch state {
        case .loading:
            state = .loadingError(error)
        case .loadingMore:
            state = .loadingMoreError(error)
        default:
            assertionFailure("Error may occur only after loading.")
        }
    }
}

// MARK: - PageType + isEmpty

extension PageType {
    
    var isEmptyPage: Bool {
        pageItems.isEmpty
    }
}
