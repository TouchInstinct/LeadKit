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

public extension GeneralDataLoadingViewModel {

    /// Manually update state to result with given value.
    ///
    /// - Parameter newResult: New value to use as result.
    func updateResultManually(to newResult: ResultType) {
        updateStateManually(to: .result(newResult: newResult, from: .just(newResult)))
    }

    /// Emit elements of ResultType from state observable.
    var resultObservable: Observable<ResultType> {
        return loadingStateObservable.flatMap { state -> Observable<ResultType> in
            switch state {
            case .result(let newResult, _):
                return .just(newResult)

            default:
                return .empty()
            }
        }
    }

    /// Emit elements of ResultType from state driver.
    var resultDriver: Driver<ResultType> {
        return loadingStateDriver.flatMap { state -> Driver<ResultType> in
            switch state {
            case .result(let newResult, _):
                return .just(newResult)

            default:
                return .empty()
            }
        }
    }
}
