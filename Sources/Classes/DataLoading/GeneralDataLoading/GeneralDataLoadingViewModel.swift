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

open class GeneralDataLoadingViewModel<ResultType>: BaseViewModel {

    public typealias LoadingModel = GeneralDataLoadingModel<ResultType>
    public typealias DataSourceType = Single<ResultType>
    public typealias LoadingState = GeneralDataLoadingState<DataSourceType>

    private let loadingModel: LoadingModel

    private let loadingStateVariable = Variable<LoadingState>(.initial)

    private let disposeBag = DisposeBag()

    /// Initializer with single result sequence and empty result checker closure.
    ///
    /// - Parameters:
    ///   - dataSource: A single element sequence.
    ///   - emptyResultChecker: Closure for checking result on empty state.
    public init(dataSource: DataSourceType,
                emptyResultChecker: @escaping LoadingModel.EmptyResultChecker = { _ in false }) {

        loadingModel = LoadingModel(dataSource: dataSource, emptyResultChecker: emptyResultChecker)

        loadingModel.stateDriver
            .drive(loadingStateVariable)
            .disposed(by: disposeBag)

        loadingModel.reload()
    }

    /// Returns driver that emits current loading state
    open var loadingStateDriver: Driver<LoadingState> {
        return loadingStateVariable.asDriver()
    }

    /// By default returns true if loading state == .result.
    open var hasContent: Bool {
        return currentLoadingState.hasResult
    }

    /// Returns current result if it exists.
    public var currentResult: ResultType? {
        return currentLoadingState.currentResult
    }

    /// Current state of loading process.
    private(set) public var currentLoadingState: LoadingState {
        get {
            return loadingStateVariable.value
        }
        set {
            loadingStateVariable.value = newValue
        }
    }

    /// Manually update loading state.
    /// Should be used only in specific situations on your own risk!
    ///
    /// - Parameter newState: New loading state.
    public func updateStateManually(to newState: LoadingState) {
        currentLoadingState = newState
    }

    /// Reload data.
    public func reload() {
        loadingModel.reload()
    }

}

public extension GeneralDataLoadingViewModel where ResultType: Collection {

    convenience init(dataSource: DataSourceType) {
        self.init(dataSource: dataSource) { $0.isEmpty }
    }

}
