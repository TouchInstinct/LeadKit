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

import TIUIKitCore
import UIKit

open class BaseFiltersCollectionView<CellType: UICollectionViewCell & ConfigurableView>: UICollectionView,
                                                                                         InitializableViewProtocol,
                                                                                         ConfigurableView,
                                                                                         FiltersCollectionHolder where CellType.ViewModelType: FilterCellViewModelProtocol {

    public var layout: UICollectionViewLayout

    public weak var viewModel: DefaultFiltersViewModel?

    // MARK: - Init

    public init(layout: UICollectionViewLayout, viewModel: DefaultFiltersViewModel? = nil) {
        self.layout = layout
        self.viewModel = viewModel
        
        super.init(frame: .zero, collectionViewLayout: layout)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    open func addViews() {
        // override in subclass
    }

    open func bindViews() {
        delegate = viewModel
        dataSource = viewModel
    }

    open func configureLayout() {
        // override in subclass
    }

    open func configureAppearance() {
        backgroundColor = .white
    }

    open func localize() {
        // override in subclass
    }

    // MARK: - ConfigurableView

    open func configure(with viewModel: DefaultFiltersViewModel) {
        self.viewModel = viewModel
        
        viewModel.filtersCollectionHolder = self

        updateView()
    }

    // MARK: - FiltersCollectionHolder

    open func applyChange(_ changes: [DefaultFiltersViewModel.Change]) {
        for change in changes {
            guard let cell = cellForItem(at: change.indexPath) else {
                continue
            }

            configure(filterCell: cell, cellViewModel: change.viewModel)
        }
    }

    open func updateView() {
        reloadData()
    }

    open func configure(filterCell: UICollectionViewCell, cellViewModel: FilterCellViewModelProtocol) {
        guard let cellViewModel = cellViewModel as? CellType.ViewModelType else { return }

        guard let configurableCell = filterCell as? CellType else { return }

        configurableCell.configure(with: cellViewModel)
    }

    open func registerCells() {
        viewModel?.filters.forEach { self.register(CellType.self, forCellWithReuseIdentifier: $0.id) }
    }
}
