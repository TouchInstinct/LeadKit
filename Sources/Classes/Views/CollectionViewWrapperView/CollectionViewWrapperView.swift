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

/// The main purpose of this class is to fix empty space on top of the screen
/// when view controller view is UICollectionView.
open class CollectionViewWrapperView: ScrollViewHolderView, CollectionViewHolder {

    /// Contained collection view.
    public let collectionView: UICollectionView

    /// Initializer with collection view layout parameter.
    ///
    /// - Parameter layout: UICollectionViewLayout to pass in UICollectionView init.
    public init(layout: UICollectionViewLayout) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        super.init(frame: .zero)

        addSubview(collectionView)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
