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

/// Protocol that describes possible states of network operation process.
public protocol NetworkOperationState {

    associatedtype DataSourceType: DataSource

    /// Initial state. Before something will happen.
    static var initialState: Self { get }

    /// Method that returns loading state after a given state.
    ///
    /// - Parameter after: Previous state of data loading process.
    /// - Returns: Instance of loading state with given argument.
    static func initialLoadingState(after: Self) -> Self

    /// Method that returns result state from a specific data source after a given state.
    ///
    /// - Parameters:
    ///   - result: DataSource result.
    ///   - from: DataSource from that a result was received.
    ///   - after: Previous state of data loading process.
    /// - Returns: Instance of result state with given arguments.
    static func resultState(result: DataSourceType.ResultType, from: DataSourceType, after: Self) -> Self

    /// Method that returns error state with a specific error after a given state.
    ///
    /// - Parameters:
    ///   - error: An error that happens due data loading process.
    ///   - after: Previous state of data loading process.
    /// - Returns: Instance of error state with given arguments.
    static func errorState(error: Error, after: Self) -> Self

    /// Returns true if current state is initial state.
    var isInitialState: Bool { get }

    /// Returns result if current state is result state.
    var result: DataSourceType.ResultType? { get }

    /// Returns error if current state is error state.
    var error: Error? { get }
}
