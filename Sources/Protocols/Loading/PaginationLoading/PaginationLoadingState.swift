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

public indirect enum PaginationLoadingState<DS: DataSourceProtocol> {

    case initial
    case loading(after: PaginationLoadingState)
    case loadingMore(after: PaginationLoadingState)
    case results(newItems: DS.ResultType, from: DS, after: PaginationLoadingState)
    case error(error: Error, after: PaginationLoadingState)
    case empty
    case exhausted

}

extension PaginationLoadingState: LoadingState {

    public typealias DataSourceType = DS

    public static var initialState: PaginationLoadingState<DS> {
        return .initial
    }

    public static var emptyState: PaginationLoadingState<DS> {
        return .empty
    }

    public static func loadingState(after: PaginationLoadingState<DS>) -> PaginationLoadingState<DS> {
        return .loading(after: after)
    }

    public static func resultState(result: DS.ResultType,
                                   from: DataSourceType,
                                   after: PaginationLoadingState<DS>) -> PaginationLoadingState<DS> {

        return .results(newItems: result, from: from, after: after)
    }

    public static func errorState(error: Error,
                                  after: PaginationLoadingState<DS>) -> PaginationLoadingState<DS> {

        return .error(error: error, after: after)
    }

}
