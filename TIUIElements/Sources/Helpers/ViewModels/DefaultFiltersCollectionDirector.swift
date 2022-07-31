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

open class DefaultFiltersCollectionDirector<FilterItem: FilterCollectionItem>: NSObject,
                                                                               CollectionDirectorRepresenter,
                                                                               UICollectionViewDataSource,
                                                                               UICollectionViewDelegate {
    
    private var _collectionItems: [FilterItem] = []
    
    public weak var collectionView: UICollectionView?
    public weak var delegate: FilterItemsDelegate?
    
    public var collectionItems: [FilterItem] {
        get {
            _collectionItems
        }
        set {
            _collectionItems = newValue
            collectionView?.reloadData()
        }
    }
    
    public init(collectionView: UICollectionView) {
        super.init()
        
        bind(to: collectionView)
    }
    
    public func insertItem(_ item: FilterItem, at index: Int) {
        collectionItems.insert(item, at: index)
        
        let indexPath = IndexPath(row: index, section: .zero)
        
        guard collectionItems.count != 1 else {
            return
        }
        
        scrollToItem(at: indexPath)
    }
    
    public func deleteItem(at index: Int) {
        collectionItems.remove(at: index)
        
        let indexPath = IndexPath(row: max(index - 1, .zero), section: .zero)
        scrollToItem(at: indexPath)
    }
    
    public func update(item: FilterItem, at index: Int) {
        _collectionItems[index] = item
    }
    
    public func scrollToItem(at indexPath: IndexPath, animated: Bool = true) {
        collectionView?.performBatchUpdates(nil, completion: { [weak self] isReady in
            if isReady {
                self?.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
            }
        })
    }
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionItems.forEach { $0.register(for: collectionView) }
        return collectionItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let viewModel = collectionItems[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.identifier, for: indexPath)
        viewModel.configure(item: cell)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        didSelectItem(atIndexPath: indexPath, cell: cell)
    }
    
    private func didSelectItem(atIndexPath indexPath: IndexPath,
                               cell: UICollectionViewCell?) {
        
        guard let item = item(at: indexPath) else { return }
        
        delegate?.didSelectItem(atIndexPath: indexPath)
        
        item.didSelectItem(atIndexPath: indexPath, cell: cell)
    }
    
    private func bind(to collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func item(at indexPath: IndexPath) -> FilterItem? {
        let index = indexPath.item
        let amount = collectionItems.count
        
        return (index < amount && index >= 0) ? collectionItems[index] : nil
    }
}
