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

open class RxNetworkOperationModel<LoadingStateType: NetworkOperationState>: NetworkOperationModel
    where LoadingStateType.DataSourceType: RxDataSource {

    public typealias DataSourceType = LoadingStateType.DataSourceType

    public typealias ErrorHandler = (Error, LoadingStateType) -> LoadingStateType

    private let stateRelay = BehaviorRelay<LoadingStateType>(value: .initialState)
    var currentRequestDisposable: Disposable?

    private(set) var dataSource: DataSourceType

    private let errorHandler: ErrorHandler

    open var stateDriver: Driver<LoadingStateType> {
        return stateRelay.asDriver()
    }

    /// Model initializer with data source and custom error handler.
    ///
    /// - Parameters:
    ///   - dataSource: Data source for network operation.
    ///   - customErrorHandler: Custom error handler for state update. Pass nil for default error handling.
    public init(dataSource: DataSourceType, customErrorHandler: ErrorHandler? = nil) {
        self.errorHandler = customErrorHandler ?? { .errorState(error: $0, after: $1) }
        self.dataSource = dataSource
    }

    /// Performs request to given data source
    public func execute() {
        currentRequestDisposable?.dispose()

        state = .initialLoadingState(after: state)

        requestResult(from: dataSource)
    }

    /// Replaces current data source with new one.
    ///
    /// - Parameter newDataSource: A new data source to use.
    public func replaceDataSource(with newDataSource: DataSourceType) {
        dataSource = newDataSource
    }

    func onGot(error: Error) {
        state = errorHandler(error, state)
    }

    func onGot(result: DataSourceType.ResultType, from dataSource: DataSourceType) {
        state = .resultState(result: result,
                             from: dataSource,
                             after: state)
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

    var state: LoadingStateType {
        get {
            return stateRelay.value
        }
        set {
            stateRelay.accept(newValue)
        }
    }

}
