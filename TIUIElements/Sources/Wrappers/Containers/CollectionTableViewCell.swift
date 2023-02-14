//
//  Copyright (c) 2023 Touch Instinct
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

open class CollectionTableViewCell<CollectionView: UICollectionView>: ContainerTableViewCell<CollectionView> {

    // MARK: - UIView Overrides

    open override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                               withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                               verticalFittingPriority: UILayoutPriority) -> CGSize {

        let cachedCollectionFrame = wrappedView.frame
        wrappedView.frame.size.width = targetSize.width - contentInsets.left - contentInsets.right
        let collectionContentHeight = wrappedView.collectionViewLayout.collectionViewContentSize.height
        wrappedView.frame = cachedCollectionFrame
        return CGSize(width: targetSize.width,
                      height: collectionContentHeight + contentInsets.top + contentInsets.bottom)
    }

    // MARK: - Open methods

    open func createCollectionLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout()
    }

    open override func createView() -> CollectionView {
        CollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
    }
}
