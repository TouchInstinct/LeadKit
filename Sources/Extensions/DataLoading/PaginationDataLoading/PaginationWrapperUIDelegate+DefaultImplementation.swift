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

import UIKit

public extension PaginationWrapperUIDelegate {

    func emptyPlaceholder() -> UIView {
        return TextPlaceholderView(title: .empty)
    }

    func customInitialLoadingErrorHandling(for error: Error) -> Bool {
        return false
    }

    func errorPlaceholder(for error: Error) -> UIView {
        return TextPlaceholderView(title: .error)
    }

    func initialLoadingIndicator() -> AnyLoadingIndicator {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.color = .gray

        return AnyLoadingIndicator(indicator)
    }

    func loadingMoreIndicator() -> AnyLoadingIndicator {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

        return AnyLoadingIndicator(indicator)
    }

    func footerRetryButton() -> UIButton {
        let retryButton = UIButton(type: .custom)
        retryButton.backgroundColor = .lightGray
        retryButton.setTitle("Retry load more", for: .normal)

        return retryButton
    }

    func footerRetryButtonHeight() -> CGFloat {
        return 44
    }

    func footerRetryButtonWillAppear() {
        // by default - nothing will happen
    }

    func footerRetryButtonWillDisappear() {
        // by default - nothing will happen
    }
}
