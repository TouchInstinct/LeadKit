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

public enum GeneralLoadingState<T> {

    case initial
    case loading
    case result(newResult: T)
    case error(error: Error)
    case empty

}

extension GeneralLoadingState: LoadingState {
    public typealias ResultType = T

    public static var initialState: GeneralLoadingState<T> {
        return .initial
    }

    public static var emptyState: GeneralLoadingState<T> {
        return .empty
    }

    public static func loadingState(after: GeneralLoadingState<T>) -> GeneralLoadingState<T> {
        return .loading
    }

    public static func resultState(result: T,
                                   after: GeneralLoadingState<T>) -> GeneralLoadingState<T> {

        return .result(newResult: result)
    }

    public static func errorState(error: Error,
                                  after: GeneralLoadingState<T>) -> GeneralLoadingState<T> {

        return .error(error: error)
    }

}
