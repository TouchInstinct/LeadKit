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

import WebKit

open class BaseWebViewModel: NSObject, WebViewModelProtocol {

    public var injector: BaseWebViewUrlInjector
    public var navigator: BaseWebViewNavigator
    public var errorHandler: BaseWebViewErrorHandler

    // MARK: - Init

    public init(injector: BaseWebViewUrlInjector = .init(),
                navigator: BaseWebViewNavigator = .init(),
                errorHandler: BaseWebViewErrorHandler = .init()) {

        self.injector = injector
        self.navigator = navigator
        self.errorHandler = errorHandler

        super.init()
    }

    // MARK: - Open methods

    open func makeUrlInjection(forWebView webView: WKWebView) {
        injector.inject(on: webView)
    }

    open func shouldNavigate(toUrl url: URL) -> WKNavigationActionPolicy {
        navigator.shouldNavigate(toUrl: url)
    }

    open func handleError(_ error: Error, url: URL?) {
        errorHandler.didRecievedError(.init(url: url, error: error))
    }

    // MARK: - WKScriptMessageHandler

    open func userContentController(_ userContentController: WKUserContentController,
                                    didReceive message: WKScriptMessage) {

        if message.name == WebViewErrorConstants.errorMessageName {
            let error = parseError(message)
            errorHandler.didRecievedError(error)
        }
    }

    // MARK: - Private methods

    private func parseError(_ message: WKScriptMessage) -> WebViewErrorModel {
        let body = message.body as? [String: Any]
        let error = body?[WebViewErrorConstants.errorPropertyName] as? String
        return .init(jsErrorMessage: error)
    }
}
