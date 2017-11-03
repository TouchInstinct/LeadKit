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

class LoadingViewModel<VMC: LoadingConfiguration>: LoadingProtocol
    where VMC.DataSourceType == VMC.LoadingStateType.DataSourceType {

    typealias DataSourceType = VMC.DataSourceType
    typealias LoadingStateType = VMC.LoadingStateType
    typealias LoadingConfigurationType = VMC

    private let configuration: VMC

    public var stateDriver: Driver<LoadingStateType> {
        return configuration.stateDriver
    }

    public required init(configuration: VMC) {
        self.configuration = configuration
    }

    func reload() {
        load(isRetry: false)
    }

    func retry() {
        load(isRetry: true)
    }

    private func load(isRetry: Bool) {
        configuration.resetDataSource()

        if isRetry {
            configuration.state = .initialState
        }

        configuration.state = .loadingState(after: configuration.state)

        let currentRequestDisposable = configuration.loadingObservable
            .observeOn(configuration.scheduler)
            .subscribe(onSuccess: { [weak self] result in
                self?.onGot(result: result)
            }, onError: { [weak self] error in
                self?.onGot(error: error)
            })

        configuration.storeCurrentRequestDisposable(currentRequestDisposable)
    }

    func onGot(error: Error) {
        configuration.state = .errorState(error: error,
                                          after: configuration.state)
    }

    func onGot(result: DataSourceType.ResultType, from dataSource: DataSourceType) {
        if configuration.isEmptyResult(result: result) {
            configuration.state = .emptyState
        } else {
            configuration.state = .resultState(result: result,
                                               from: dataSource,
                                               after: configuration.state)
        }
    }

    private func onGot(result: DataSourceType.ResultType) {
        onGot(result: result, from: configuration.dataSource)
    }

}
