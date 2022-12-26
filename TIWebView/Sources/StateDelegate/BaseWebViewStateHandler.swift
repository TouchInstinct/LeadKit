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

open class BaseWebViewStateHandler: NSObject, WebViewStateHandler {

    public weak var viewModel: WebViewModelProtocol?

    // MARK: - WebViewStateHandler

    open func navigationProgress(_ progress: Double, isLoading: Bool) {
        // Override in subclass
    }

    // MARK: - WKNavigationDelegate

    open func webView(_ webView: WKWebView,
                      decidePolicyFor navigationAction: WKNavigationAction,
                      decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url else {
            return decisionHandler(.cancel)
        }

        let decision = viewModel?.shouldNavigate(toUrl: url) ?? .cancel
        decisionHandler(decision)
    }

    open func webView(_ webView: WKWebView, didCommit navigation: WKNavigation?) {
    }

    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation?) {
        viewModel?.makeUrlInjection(forWebView: webView)
    }

    open func webView(_ webView: WKWebView,
                      didFailProvisionalNavigation navigation: WKNavigation?,
                      withError error: Error) {
        viewModel?.handleError(error, url: webView.url)
    }

    open func webView(_ webView: WKWebView,
                      didFail navigation: WKNavigation?,
                      withError error: Error) {

        viewModel?.handleError(error, url: webView.url)
    }
}
