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

/// Enum that contains states for paginated data loading.
///
/// - initial: Initial state. Before something will happen.
/// - initialLoading: Initial loading state. When data was requested initially.
/// - loadingMore: Loading more state. When additional data was requested.
/// - results: Result state from a specific data source after a given state.
/// - error: Error state with a specific error after a given state.
/// - empty: Empty state. When data was initially requested and empty result was received.
/// - exhausted: Exhausted state. When no more results can be received.
public indirect enum PaginationDataLoadingState<DS: DataSource> {

    case initial
    case initialLoading(after: PaginationDataLoadingState)
    case loadingMore(after: PaginationDataLoadingState)
    case results(newItems: DS.ResultType, from: DS, after: PaginationDataLoadingState)
    case error(error: Error, after: PaginationDataLoadingState)
    case empty
    case exhausted
}

extension PaginationDataLoadingState: DataLoadingState {

    public typealias DataSourceType = DS

    public static var initialState: PaginationDataLoadingState<DS> {
        return .initial
    }

    public static var emptyState: PaginationDataLoadingState<DS> {
        return .empty
    }

    public static func initialLoadingState(after: PaginationDataLoadingState<DS>) -> PaginationDataLoadingState<DS> {
        return .initialLoading(after: after)
    }

    public static func resultState(result: DS.ResultType,
                                   from: DataSourceType,
                                   after: PaginationDataLoadingState<DS>) -> PaginationDataLoadingState<DS> {

        return .results(newItems: result, from: from, after: after)
    }

    public static func errorState(error: Error,
                                  after: PaginationDataLoadingState<DS>) -> PaginationDataLoadingState<DS> {

        return .error(error: error, after: after)
    }

    public var isInitialState: Bool {
        switch self {
        case .initial:
            return true

        default:
            return false
        }
    }

    public var result: DS.ResultType? {
        switch self {
        case .results(let newItems, _, _):
            return newItems

        default:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .error(let error, _):
            return error

        default:
            return nil
        }
    }
}
