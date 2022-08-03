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
public extension UICollectionViewLayout {

    static func gridLayout(_ conf: FiltersLayoutConfiguration) -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: conf.itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: conf.itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(conf.horizontalItemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(insets: conf.contentInsets)
        section.interGroupSpacing = conf.verticalItemSpacing

        return UICollectionViewCompositionalLayout(section: section)
    }

    static func horizontalScrollLayout(_ conf: FiltersLayoutConfiguration) -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: conf.itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: conf.itemSize.widthDimension,
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(insets: conf.contentInsets)
        section.interGroupSpacing = conf.horizontalItemSpacing
        section.orthogonalScrollingBehavior = .continuous

        return UICollectionViewCompositionalLayout(section: section)
    }
}

private extension NSDirectionalEdgeInsets {
    init(insets: UIEdgeInsets) {
        self.init(top: insets.top,
                  leading: insets.left,
                  bottom: insets.bottom,
                  trailing: insets.right)
    }
}
