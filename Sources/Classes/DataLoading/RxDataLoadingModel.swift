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

open class RxDataLoadingModel<LoadingStateType: DataLoadingState>: RxNetworkOperationModel<LoadingStateType>
    where LoadingStateType.DataSourceType: RxDataSource {

    public typealias EmptyResultChecker = (ResultType) -> Bool

    let emptyResultChecker: EmptyResultChecker

    /// Model initializer with data source, empty result checker and custom error handler.
    ///
    /// - Parameters:
    ///   - dataSource: Data source for data loading.
    ///   - customErrorHandler: Custom error handler for state update. Pass nil for default error handling.
    ///   - emptyResultChecker: Empty result checker closure.
    public init(dataSource: DataSourceType,
                customErrorHandler: ErrorHandler? = nil,
                emptyResultChecker: @escaping EmptyResultChecker) {

        self.emptyResultChecker = emptyResultChecker

        super.init(dataSource: dataSource, customErrorHandler: customErrorHandler)
    }

    open func reload() {
        execute()
    }

    override func onGot(result: ResultType, from dataSource: DataSourceType) {
        if emptyResultChecker(result) {
            state = .emptyState
        } else {
            super.onGot(result: result, from: dataSource)
        }

        updateStateAfterResult(from: dataSource)
    }

    func updateStateAfterResult(from dataSource: DataSourceType) {
        // override in subcass if needed
    }
}
