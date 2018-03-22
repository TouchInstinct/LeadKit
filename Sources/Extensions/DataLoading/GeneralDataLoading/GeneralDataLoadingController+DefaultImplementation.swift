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

import RxCocoa

public extension GeneralDataLoadingController where Self: UIViewController {

    // MARK: - StatefulViewController default implementation

    func hasContent() -> Bool {
        return viewModel.hasContent
    }

    // MARK: - GeneralDataLoadingController default implementation

    func initialLoadDataLoadingView() {
        addViews()
        setAppearance()
        setupStateViews()
        configureBarButtons()
        localize()
        bindViews()
        bindLoadingState()
    }

    func setupStateViews() {
        loadingView = TextPlaceholderView(title: .loading)
        errorView = TextWithButtonPlaceholder(title: .error,
                                              buttonTitle: .retryLoadMore,
                                              tapHandler: reload)
        emptyView = TextPlaceholderView(title: .empty)
    }

    func reload() {
        viewModel.reload()
    }

    private var stateChanged: Binder<ViewModelT.LoadingState> {
        return Binder(self) { base, value in
            switch value {
            case .loading:
                base.onLoadingState()
            case .result(let newResult, _):
                base.onResultsState(result: newResult)
            case .empty:
                base.onEmptyState()
            case .error(let error):
                base.onErrorState(error: error)
            case .initial:
                break
            }
        }
    }

}

public extension GeneralDataLoadingController where Self: UIViewController & DisposeBagHolder {

    func bindLoadingState() {
        viewModel.loadingStateDriver
            .drive(stateChanged)
            .disposed(by: disposeBag)
    }

}
