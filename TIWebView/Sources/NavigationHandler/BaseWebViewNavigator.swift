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

import Foundation
import enum WebKit.WKNavigationActionPolicy

open class BaseWebViewNavigator: WebViewNavigatorProtocol {

    public typealias WebViewNavigationMap = [WebViewUrlComparator: NavigationResult]

    public let navigationMap: WebViewNavigationMap

    public init(navigationMap: WebViewNavigationMap) {
        self.navigationMap = navigationMap
    }

    public convenience init() {
        self.init(navigationMap: [:])
    }

    open func shouldNavigate(toUrl url: URL) -> WKNavigationActionPolicy {
        guard !navigationMap.isEmpty else {
            return .cancel
        }

        let decision = navigationMap.first { (comparator, _) in
            url.compare(by: comparator)
        }?.value

        switch decision {
        case let .closure(closure):
            return closure(url)

        case let .simpleResult(result):
            return result

        case .none:
            return .cancel
        }
    }
}
