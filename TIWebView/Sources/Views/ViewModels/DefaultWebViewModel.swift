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

open class DefaultWebViewModel: NSObject, WebViewModel {

    public var injector: WebViewUrlInjector
    public var navigator: WebViewNavigator
    public var errorHandler: WebViewErrorHandler

    // MARK: - Init

    public init(injector: WebViewUrlInjector = BaseWebViewUrlInjector(),
                navigator: WebViewNavigator = BaseWebViewNavigator(),
                errorHandler: WebViewErrorHandler = BaseWebViewErrorHandler()) {

        self.injector = injector
        self.navigator = navigator
        self.errorHandler = errorHandler

        super.init()
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

    private func parseError(_ message: WKScriptMessage) -> WebViewError {
        let body = message.body as? [String: Any]
        return WebViewJSError(stringURL: body?[WebViewErrorConstants.errorUrl] as? String,
                              name: body?[WebViewErrorConstants.errorName] as? String,
                              message: body?[WebViewErrorConstants.errorMessage] as? String,
                              lineNumber: body?[WebViewErrorConstants.errorLineNumber] as? Int,
                              stackTrace: body?[WebViewErrorConstants.errorStack] as? String)
    }
}
