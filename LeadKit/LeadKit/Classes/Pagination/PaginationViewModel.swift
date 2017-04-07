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

public typealias ResettableCursorType = CursorType & ResettableType

public final class PaginationViewModel<C: ResettableCursorType> {

    public indirect enum State {

        case initial
        case loading(after: State) // can be after any state
        case loadingMore(after: State) // can be after error or results
        case results(newItems: [C.Element], after: State) // can be after loading or loadingMore
        case error(error: Error, after: State) // can be after loading or loadingMore
        case empty // can be after loading or loadingMore
        case exhausted // can be after results

    }

    public enum LoadType {

        case reload
        case next

    }

    private var cursor: C

    private let internalState = Variable<State>(.initial)

    private var currentRequest: Disposable?

    private let internalScheduler = SerialDispatchQueueScheduler(qos: .default)

    public var state: Driver<State> {
        return internalState.asDriver()
    }

    public init(cursor: C) {
        self.cursor = cursor
    }

    public func load(_ loadType: LoadType) {
        switch loadType {
        case .reload:
            currentRequest?.dispose()
            cursor = cursor.reset()

            internalState.value = .loading(after: internalState.value)
        case .next:
            if case .exhausted(_) = internalState.value {
                preconditionFailure("You shouldn't call load(.next) after got .exhausted state!")
            }

            internalState.value = .loadingMore(after: internalState.value)
        }

        currentRequest = cursor.loadNextBatch()
            .subscribeOn(internalScheduler)
            .subscribe(onNext: { [weak self] newItems in
                self?.onGot(newItems: newItems)
            }, onError: { [weak self] error in
                self?.onGot(error: error)
            })
    }

    private func onGot(newItems: [C.Element]) {
        if newItems.count > 0 {
            internalState.value = .results(newItems: newItems, after: internalState.value)
        } else {
            internalState.value = .empty
        }

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

}
