//
//  Copyright (c) 2020 Touch Instinct
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

public protocol WebViewNavigationDelegate {
    func navigationProgress(_ progress: Double, isLoading: Bool)
    func didCommit(_ navigation: WKNavigation, forWebView webView: WKWebView)
    func didFinish(_ navigation: WKNavigation!, forWebView webView: WKWebView)
    func didFailProvisionalNavigation(_ navigation: WKNavigation!, withError error: Error, forWebView webView: WKWebView)
    func didFail(_ navigation: WKNavigation!, withError error: Error, forWebView webView: WKWebView)
}

public extension WebViewNavigationDelegate {
    func navigationProgress(_ progress: Double, isLoading: Bool) {
        // empty implementation
    }

    func didCommit(_ navigation: WKNavigation, forWebView webView: WKWebView) {
        // empty implementation
    }

    func didFinish(_ navigation: WKNavigation!, forWebView webView: WKWebView) {
        // empty implementation
    }

    func didFail(_ navigation: WKNavigation!, withError error: Error, forWebView webView: WKWebView) {
        // empty implementation
    }
}
