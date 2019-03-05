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

/// Enum that contains states for general data loading.
///
/// - initial: Initial state. Before something will happen.
/// - loading: Loading state. When data loading is started.
/// - result: Result state from a specific data source with result.
/// - error: Error state with a specific error.
/// - empty: Empty state. When data was requested and empty result was received.
public enum GeneralDataLoadingState<DS: DataSource> {

    case initial
    case loading
    case result(newResult: DS.ResultType, from: DS)
    case error(error: Error)
    case empty
}

extension GeneralDataLoadingState: DataLoadingState {

    public typealias DataSourceType = DS

    public static var initialState: GeneralDataLoadingState<DS> {
        return .initial
    }

    public static var emptyState: GeneralDataLoadingState<DS> {
        return .empty
    }

    public static func initialLoadingState(after: GeneralDataLoadingState<DS>) -> GeneralDataLoadingState<DS> {
        return .loading
    }

    public static func resultState(result: DS.ResultType,
                                   from: DS,
                                   after: GeneralDataLoadingState<DS>) -> GeneralDataLoadingState<DS> {

        return .result(newResult: result, from: from)
    }

    public static func errorState(error: Error,
                                  after: GeneralDataLoadingState<DS>) -> GeneralDataLoadingState<DS> {

        return .error(error: error)
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
        case .result(let newResult, _):
            return newResult

        default:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .error(let error):
            return error

        default:
            return nil
        }
    }
}
