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

/// PaginationWrapper UI delegate used for customization
/// of bound states (loading, empty, error, etc.).
public protocol PaginationWrapperUIDelegate: AnyObject {

    /// Returns placeholder view for empty state.
    ///
    /// - Returns: Configured instace of UIView.
    func emptyPlaceholder() -> UIView?

    /// Called when initial loading error is occured.
    /// It should return true if error is handled and false if it doesn't.
    ///
    /// - Parameters:
    ///   - error: Error that occured due data loading.
    /// - Returns: Bool value. If true - then error placeholder wouldn't be shown.
    func customInitialLoadingErrorHandling(for error: Error) -> Bool

    /// Returns placeholder view for error state.
    ///
    /// - Parameters:
    ///   - error: Error that occured due data loading.
    /// - Returns: Configured instace of UIView.
    func errorPlaceholder(for error: Error) -> UIView?

    /// Returns loading idicator for initial loading state.
    /// This indicator will appear at center of the placeholders container.
    ///
    /// - Returns: Configured instace of AnyLoadingIndicator.
    func initialLoadingIndicator() -> AnyLoadingIndicator?

    /// Returns loading idicator for initial loading state.
    ///
    /// - Returns: Configured instace of AnyLoadingIndicator.
    func loadingMoreIndicator() -> AnyLoadingIndicator?

    /// Returns instance of ButtonHolderView with retry button for "retry load more" action.
    ///
    /// - Returns: Configured instace of AnyLoadingIndicator.
    func footerRetryView() -> ButtonHolderView?

    /// Returns height for "retry load more" button.
    ///
    /// - Returns: Height of "retry load more" button.
    func footerRetryViewHeight() -> CGFloat

    /// Method is called before "retry load more" will be shown.
    /// Typically, it's used when you need to show custom footer view.
    func footerRetryViewWillAppear()

    /// Method is called before "retry load more" will be hidden.
    /// Typically, it's used when you need to hide custom footer view.
    func footerRetryViewWillDisappear()
}
