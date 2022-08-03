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

import UIKit

@available(iOS 13, *)
public struct FiltersLayoutConfiguration {
    
    public var itemSize: NSCollectionLayoutSize
    public var horizontalItemSpacing: CGFloat
    public var verticalItemSpacing: CGFloat
    public var contentInsets: UIEdgeInsets

    public init(itemSize: NSCollectionLayoutSize = .init(widthDimension: .estimated(32),
                                                         heightDimension: .estimated(32)),
                horizontalItemSpacing: CGFloat = .zero,
                verticalItemSpacing: CGFloat = .zero,
                contentInsets: UIEdgeInsets) {

        self.itemSize = itemSize
        self.horizontalItemSpacing = horizontalItemSpacing
        self.verticalItemSpacing = verticalItemSpacing
        self.contentInsets = contentInsets
    }
}

@available(iOS 13, *)
public extension FiltersLayoutConfiguration {
    static let horizontalScrollConfiguration = FiltersLayoutConfiguration(horizontalItemSpacing: 16,
                                                                          contentInsets: .init(top: .zero,
                                                                                               left: 8,
                                                                                               bottom: .zero,
                                                                                               right: 8))

    static let gridConfiguration = FiltersLayoutConfiguration(horizontalItemSpacing: 16,
                                                              verticalItemSpacing: 16,
                                                              contentInsets: .init(top: .zero,
                                                                                   left: 8,
                                                                                   bottom: .zero,
                                                                                   right: 8))
}
