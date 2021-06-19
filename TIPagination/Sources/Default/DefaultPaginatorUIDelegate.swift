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

import UIKit
import TISwiftUtils

open class DefaultPaginatorUIDelegate<Cursor: PaginatorCursorType>: PaginatorUIDelegate {
    
    public typealias ViewSetter = ParameterClosure<UIView?>
    
    // MARK: - Private Properties
    
    private let scrollView: UIScrollView
    private let backgroundViewSetter: ViewSetter
    private let footerViewSetter: ViewSetter
    
    private var currentPlaceholderView: UIView?

    // MARK: - Public Properties
    
    /// Called when default retry button is pressed
    public var onRetry: VoidClosure?
    
    // MARK: - Public Initializers
    
    public convenience init(_ tableView: UITableView) {
        self.init(scrollView: tableView,
                  backgroundViewSetter: { [weak tableView] in
                      tableView?.backgroundView = $0
                  }, footerViewSetter: { [weak tableView] in
                      tableView?.tableFooterView = $0
                  })
    }
    
    public convenience init(_ collectionView: UICollectionView) {
        self.init(scrollView: collectionView,
                  backgroundViewSetter: { [weak collectionView] in
                      collectionView?.backgroundView = $0
                  }, footerViewSetter: { _ in
                      // No footer in UICollectionView
                  })
    }

    public init(scrollView: UIScrollView,
                backgroundViewSetter: @escaping ViewSetter,
                footerViewSetter: @escaping ViewSetter) {
        
        self.scrollView = scrollView
        self.backgroundViewSetter = backgroundViewSetter
        self.footerViewSetter = footerViewSetter
    }
    
    // MARK: - UI Setup
    
    open func footerRetryView() -> UIView? {
        let retryButton = UIButton(type: .custom)
        retryButton.backgroundColor = .lightGray
        retryButton.setTitle("Retry load more", for: .normal)

        retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        
        return retryButton
    }
    
    open func footerRetryViewHeight() -> CGFloat {
        44
    }
    
    open func emptyPlaceholder() -> UIView? {
        let label = UILabel()
        label.text = "Empty"
        
        return label
    }
    
    open func errorPlaceholder(for error: Cursor.Failure) -> UIView? {
        let label = UILabel()
        label.text = error.localizedDescription
        
        return label
    }
    
    // MARK: - PaginatorUIDelegate
    
    open func onInitialLoading() {
        scrollView.isUserInteractionEnabled = false
        removeAllPlaceholders()

        let loadingIndicatorView = UIActivityIndicatorView()
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = true

        backgroundViewSetter(loadingIndicatorView)
        loadingIndicatorView.startAnimating()

        currentPlaceholderView = loadingIndicatorView
    }
    
    open func onReloading() {
        footerViewSetter(nil)
    }
    
    open func onLoadingMore() {
        footerViewSetter(nil)
    }
    
    open func onLoadingError(_ error: Cursor.Failure) {
        guard let errorView = errorPlaceholder(for: error) else {
            return
        }

        replacePlaceholderViewIfNeeded(with: errorView)
        scrollView.refreshControl?.endRefreshing()
    }
    
    open func onLoadingMoreError(_ error: Cursor.Failure) {
        guard let retryView = footerRetryView() else {
            return
        }
        
        let retryViewHeight = footerRetryViewHeight()

        retryView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: scrollView.bounds.width,
                                 height: retryViewHeight)

        footerViewSetter(retryView)

        let contentOffsetWithRetryView = scrollView.contentOffset.y + retryViewHeight
        let invisibleContentHeight = scrollView.contentSize.height - scrollView.frame.size.height
        
        let shouldUpdateContentOffset = contentOffsetWithRetryView >= invisibleContentHeight

        if shouldUpdateContentOffset {
            scrollView.setContentOffset(CGPoint(x: 0, y: contentOffsetWithRetryView),
                                        animated: true)
        }
    }
    
    open func onSuccessfulLoad() {
        scrollView.isUserInteractionEnabled = true
        removeAllPlaceholders()
        scrollView.refreshControl?.endRefreshing()
    }
    
    open func onEmptyState() {
        guard let emptyView = emptyPlaceholder() else {
            return
        }

        replacePlaceholderViewIfNeeded(with: emptyView)
        scrollView.refreshControl?.endRefreshing()
    }
    
    open func onExhaustedState() {
        removeAllPlaceholders()
    }
    
    open func onAddInfiniteScroll() {
        // empty
    }
    
    // MARK: - Private Methods
    
    private func replacePlaceholderViewIfNeeded(with placeholderView: UIView) {
        scrollView.isUserInteractionEnabled = true
        removeAllPlaceholders()

        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.isHidden = false

        // I was unable to add pull-to-refresh placeholder scroll behaviour without this trick
        let placeholderWrapperView = UIView()
        placeholderWrapperView.addSubview(placeholderView)

        let leadingConstraint = placeholderView.leadingAnchor.constraint(equalTo: placeholderWrapperView.leadingAnchor)
        let trailingConstraint = placeholderView.trailingAnchor.constraint(equalTo: placeholderWrapperView.trailingAnchor)
        let topConstraint = placeholderView.topAnchor.constraint(equalTo: placeholderWrapperView.topAnchor)
        let bottomConstraint = placeholderView.bottomAnchor.constraint(equalTo: placeholderWrapperView.bottomAnchor)

        NSLayoutConstraint.activate([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            bottomConstraint
        ])

        backgroundViewSetter(placeholderWrapperView)
        currentPlaceholderView = placeholderView
    }
    
    private func removeAllPlaceholders() {
        backgroundViewSetter(nil)
        footerViewSetter(nil)
    }
    
    @objc private func retryAction() {
        onRetry?()
    }
}
