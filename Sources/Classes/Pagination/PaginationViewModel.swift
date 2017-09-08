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

import RxSwift
import RxCocoa

/// Cursor type which can be resetted
public typealias ResettableCursorType = CursorType & ResettableType

/// Class that encapsulate all pagination logic
public final class PaginationViewModel<C: ResettableCursorType> {

    /// Enum contains all possible states for PaginationViewModel class.
    ///
    /// - initial: initial state of view model.
    /// Can occur only once after initial binding.
    /// - loading: loading state of view model. Contains previous state of view model.
    /// Can occur after any state.
    /// - loadingMore: loading more items state of view model. Contains previous state of view model.
    /// Can occur after error or results state.
    /// - results: results state of view model. Contains loaded items, cursor and previous state of view model.
    /// Can occur after loading or loadingMore state.
    /// - error: error state of view model. Contains received error and previous state of view model.
    /// Can occur after loading or loadingMore state.
    /// - empty: empty state of view model.
    /// Can occur after loading or loadingMore state when we got empty result (zero items).
    /// - exhausted: exhausted state of view model.
    /// Can occur after results state or after initial->loading state when cursor reports that it's exhausted.
    public indirect enum State {

        case initial
        case loading(after: State)
        case loadingMore(after: State)
        case results(newItems: [C.Element], inCursor: C, after: State)
        case error(error: Error, after: State)
        case empty
        case exhausted

    }

    /// Enum represents possible load types for PaginationViewModel class
    ///
    /// - reload: reload all items and reset cursor to initial state.
    /// - next: load next batch of items.
    /// - retry: reload to initial loading state
    public enum LoadType {

        case reload
        case retry
        case next

    }

    private var cursor: C

    private let internalState = Variable<State>(.initial)

    private var currentRequest: Disposable?

    private let internalScheduler = SerialDispatchQueueScheduler(qos: .default)

    /// Current PaginationViewModel state Driver
    public var state: Driver<State> {
        return internalState.asDriver()
    }

    /// Initializer with enclosed cursor
    ///
    /// - Parameter cursor: cursor to use for pagination
    public init(cursor: C) {
        self.cursor = cursor
    }

    /// Mathod which triggers loading of items.
    ///
    /// - Parameter loadType: type of loading. See LoadType enum.
    public func load(_ loadType: LoadType) {
        switch loadType {
        case .reload:
            reload()
        case .retry:
            reload(isRetry: true)
        case .next:
            if case .exhausted(_) = internalState.value {
                fatalError("You shouldn't call load(.next) after got .exhausted state!")
            }

            internalState.value = .loadingMore(after: internalState.value)
        }

        let currentCursor = cursor

        currentRequest = currentCursor.loadNextBatch()
            .subscribeOn(internalScheduler)
            .subscribe(onSuccess: { [weak self] newItems in
                self?.onGot(newItems: newItems, using: currentCursor)
            }, onError: { [weak self] error in
                self?.onGot(error: error)
            })
    }

    private func onGot(newItems: [C.Element], using cursor: C) {
        if newItems.isEmpty {
            internalState.value = .empty
            return
        }

        internalState.value = .results(newItems: newItems, inCursor: cursor, after: internalState.value)

        if cursor.exhausted {
            internalState.value = .exhausted
        }
    }

    private func onGot(error: Error) {
        if case .exhausted? = error as? CursorError, case .loading(let after) = internalState.value {
            switch after {
            case .initial, .empty: // cursor exhausted after creation
                internalState.value = .empty
            default:
                internalState.value = .error(error: error, after: internalState.value)
            }
        } else {
            internalState.value = .error(error: error, after: internalState.value)
        }
    }

    private func reload(isRetry: Bool = false) {
        currentRequest?.dispose()
        cursor = cursor.reset()

        if isRetry {
            internalState.value = .initial
        }
        internalState.value = .loading(after: internalState.value)
    }

}
