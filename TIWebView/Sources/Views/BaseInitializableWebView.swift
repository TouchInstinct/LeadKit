//
//  Copyright (c) 2022 Touch Instinct
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

import TISwiftUtils
import TIUIKitCore
import WebKit

open class BaseInitializableWebView: WKWebView,
                                     InitializableViewProtocol,
                                     ConfigurableView {

    public var stateHandler: WebViewStateHandler
    public var viewModel: WebViewModel? {
        didSet {
            stateHandler.viewModel = viewModel
        }
    }

    // MARK: - Init

    public init(stateHandler: WebViewStateHandler = BaseWebViewStateHandler()) {
        self.stateHandler = stateHandler

        super.init(frame: .zero, configuration: .init())

        initializeView()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - InitializableViewProtocol

    public func addViews() {
        // override in subviews
    }

    public func configureLayout() {
        // override in subviews
    }

    public func bindViews() {
        navigationDelegate = stateHandler
    }

    public func configureAppearance() {
        // override in subviews
    }

    public func localize() {
        // override in subviews
    }

    // MARK: - ConfigurableView

    open func configure(with viewModel: WebViewModel) {
        self.viewModel = viewModel

        configuration.userContentController.add(viewModel, name: WebViewErrorConstants.errorMessageName)
    }

    // MARK: - Public methods

    public func subscribe(onProgress: ParameterClosure<Double>?) -> NSKeyValueObservation {
        observe(\.estimatedProgress, options: [.new]) { webView, change in
            if webView.isLoading, let newValue = change.newValue {
                onProgress?(newValue)
            }
        }
    }
}
