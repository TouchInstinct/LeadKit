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

/// Enum that contains states for network operation request.
///
/// - initial: Initial state. Before something will happen.
/// - processing: Loading state. When request is started.
/// - done: Result state with result.
/// - failed: Error state with a specific error.
public enum RequestNetworkOperationState<DS: DataSource>: NetworkOperationState {

    case initial
    case processing
    case done(result: DS.ResultType)
    case failed(error: Error)

    public typealias DataSourceType = DS

    public static var initialState: RequestNetworkOperationState<DS> {
        return .initial
    }

    public static func initialLoadingState(after: RequestNetworkOperationState<DS>) -> RequestNetworkOperationState<DS> {
        return .processing
    }

    public static func resultState(result: DS.ResultType,
                                   from: DS,
                                   after: RequestNetworkOperationState<DS>) -> RequestNetworkOperationState<DS> {

        return .done(result: result)
    }

    public static func errorState(error: Error,
                                  after: RequestNetworkOperationState<DS>) -> RequestNetworkOperationState<DS> {

        return .failed(error: error)
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
        case .done(let result):
            return result
        default:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .failed(let error):
            return error
        default:
            return nil
        }
    }

}
