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
    
    static func makeHorizontalLayout(_ conf: FiltersLayoutConfiguration) -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: conf.itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: conf.groupSize, subitems: [item])
        group.interItemSpacing = conf.itemSpacing

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(insets: conf.contentInsets)
        section.interGroupSpacing = conf.groupSpacing

        return UICollectionViewCompositionalLayout(section: section)
    }

    static func makeHorizontalScrollLayout(_ conf: FiltersLayoutConfiguration) -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: conf.itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: conf.groupSize, subitems: [item])
        group.interItemSpacing = conf.itemSpacing

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(insets: conf.contentInsets)
        section.interGroupSpacing = conf.groupSpacing
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
