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

import Foundation
import class WebKit.WKWebView

public typealias URLInjection = [WebViewUrlComparator: [WebViewUrlInjection]]

public protocol WebViewUrlInjector {
    var injection: URLInjection { get set }

    func inject(into webView: WKWebView)
}

public extension WebViewUrlInjector {

    func inject(into webView: WKWebView) {
        guard !injection.isEmpty, let url = webView.url else {
            return
        }

        injection.forEach { (comparator, injections) in
            guard url.compare(by: comparator) else {
                return
            }

            injections.forEach { evaluteInjection(onWebView: webView, injection: $0) }
        }
    }

    // MARK: - Helper methods

    private func evaluteInjection(onWebView webView: WKWebView, injection: WebViewUrlInjection) {
        let jsScript = makeJsScript(fromInjection: injection)

        guard !jsScript.isEmpty else {
            return
        }

        webView.evaluateJavaScript(jsScript, completionHandler: nil)
    }

    private func makeJsScript(fromInjection injection: WebViewUrlInjection) -> String {
        switch injection {
        case let .css(css):
            return cssJsScript(css: css)

        case let .cssForFile(url):
            let css = try? String(contentsOf: url)
                .components(separatedBy: .newlines)
                .joined()

            return cssJsScript(css: css ?? "")

        case let .javaScript(script):
            return script
        }
    }

    private func cssJsScript(css: String) -> String {
        """
        var style = document.createElement('style');
        style.innerHTML = '\(css)';
        document.head.appendChild(style);
        """
    }
}
