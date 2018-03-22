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

public protocol GeneralDataLoadingController: class, ConfigurableController
    where ViewModelT: GeneralDataLoadingViewModel<ViewModelResultType> {

    associatedtype ViewModelResultType

    /// The loading view is shown when the `onLoadingState` method gets called
    var loadingView: UIView? { get set }

    /// The error view is shown when the `onErrorState` method gets called
    var errorView: UIView? { get set }

    /// The empty view is shown when the `hasContent` method returns false
    var emptyView: UIView? { get set }

    /// Method for setting up error, empty and loading placeholders.
    func setupStateViews()

    /// Method for binding view model state driver to view controller.
    func bindLoadingState()

    /// Called when retry action performed.
    func reload()

    /// Shold be called in viewDidLoad() instead of initialLoadView().
    func initialLoadDataLoadingView()

    /// Called when data loading has started.
    func onLoadingState()

    /// Called when data loading has finished with non-empty result.
    func onResultsState()

    /// Called when data loading did finished with empty result.
    func onEmptyState()

    /// Gets called when error is occured during data loading.
    ///
    /// - Parameter error: An error that might have occurred whilst loading
    func onErrorState(error: Error)

}
