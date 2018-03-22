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

open class RxDataLoadingModel<LoadingStateType: DataLoadingState>: DataLoadingModel
    where LoadingStateType.DataSourceType: RxDataSource {

    public typealias DataSourceType = LoadingStateType.DataSourceType
    public typealias ResultType = DataSourceType.ResultType

    public typealias EmptyResultChecker = (ResultType) -> Bool

    private let stateVariable = Variable<LoadingStateType>(.initialState)
    var currentRequestDisposable: Disposable?

    var dataSource: DataSourceType
    let emptyResultChecker: EmptyResultChecker

    open var stateDriver: Driver<LoadingStateType> {
        return stateVariable.asDriver()
    }

    public init(dataSource: DataSourceType, emptyResultChecker: @escaping EmptyResultChecker) {
        self.dataSource = dataSource
        self.emptyResultChecker = emptyResultChecker
    }

    open func reload() {
        load(isRetry: false)
    }

    open func retry() {
        load(isRetry: true)
    }

    private func load(isRetry: Bool) {
        currentRequestDisposable?.dispose()

        if isRetry {
            state = .initialState
        }

        state = .initialLoadingState(after: state)

        requestResult(from: dataSource)
    }

    func onGot(error: Error) {
        state = .errorState(error: error, after: state)
    }

    private func onGot(result: ResultType, from dataSource: DataSourceType) {
        if emptyResultChecker(result) {
            state = .emptyState
        } else {
            state = .resultState(result: result,
                                 from: dataSource,
                                 after: state)

            updateStateAfterNonEmptyResult(from: dataSource)
        }
    }

    func requestResult(from dataSource: DataSourceType) {
        currentRequestDisposable = dataSource
            .resultSingle()
            .subscribe(onSuccess: { [weak self] result in
                self?.onGot(result: result, from: dataSource)
            }, onError: { [weak self] error in
                self?.onGot(error: error)
            })
    }

    func updateStateAfterNonEmptyResult(from dataSource: DataSourceType) {
        // override in subcass if needed
    }

    var state: LoadingStateType {
        get {
            return stateVariable.value
        }
        set {
            stateVariable.value = newValue
        }
    }

}
