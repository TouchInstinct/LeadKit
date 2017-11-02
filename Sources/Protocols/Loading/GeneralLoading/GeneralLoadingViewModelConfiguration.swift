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

public final class GeneralLoadingViewModelConfiguration<T>: LoadingConfiguration {

    public typealias DataSourceType = Single<T>
    public typealias ResultType = T
    public typealias EmptyResultChecker = (T) -> Bool
    public typealias LoadingStateType = GeneralLoadingState<T>

    private let stateVariable = Variable<LoadingStateType>(.initialState)
    private var currentRequestDisposable: Disposable?
    public let scheduler = SerialDispatchQueueScheduler(qos: .default)

    public let dataSource: DataSourceType
    public let emptyResultChecker: EmptyResultChecker

    public init(dataSource: DataSourceType, emptyResultChecker: @escaping EmptyResultChecker) {
        self.dataSource = dataSource
        self.emptyResultChecker = emptyResultChecker
    }

    public var loadingObservable: DataSourceType {
        return dataSource
    }

    public func isEmptyResult(result: T) -> Bool {
        return emptyResultChecker(result)
    }

    public var stateDriver: Driver<LoadingStateType> {
        return stateVariable.asDriver()
    }

    public var state: GeneralLoadingState<T> {
        get {
            return stateVariable.value
        }
        set {
            stateVariable.value = newValue
        }
    }

    public func resetDataSource() {
        currentRequestDisposable?.dispose()
    }

    public func storeCurrentRequestDisposable(_ disposable: Disposable) {
        currentRequestDisposable = disposable
    }

}
