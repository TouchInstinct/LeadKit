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

@available(iOS 13.0, *)
open class BaseFiltersCollectionView<CellType: UICollectionViewCell & ConfigurableView>: UICollectionView,
                                                                                         InitializableViewProtocol,
                                                                                         UICollectionViewDelegate where CellType.ViewModelType: Hashable {

    public enum Section {
        case main
    }

    public typealias DataSource = UICollectionViewDiffableDataSource<Section, CellType.ViewModelType>
    public typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CellType.ViewModelType>

    public var layout: UICollectionViewLayout

    public weak var viewModel: DefaultFiltersViewModel?

    public lazy var collectionViewDataSource = createDataSource()

    open var cellsReusedIdentifier: String {
        "filter-cells-identifier"
    }

    // MARK: - Init

    public init(layout: UICollectionViewLayout, viewModel: DefaultFiltersViewModel? = nil) {
        self.layout = layout
        self.viewModel = viewModel
        
        super.init(frame: .zero, collectionViewLayout: layout)

        initializeView()
        viewDidLoad()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    open func addViews() {
        // override in subclass
    }

    open func bindViews() {
        delegate = self
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

    open func viewDidLoad() {
        register(CellType.self, forCellWithReuseIdentifier: cellsReusedIdentifier)

        applySnapshot()
    }

    // MARK: - UICollectionViewDelegate

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        let changes = viewModel.filterDidSelected(atIndexPath: indexPath)

        applyChange(changes)
    }

    // MARK: - Open methods

    open func applySnapshot() {
        guard let viewModel = viewModel else {
            return
        }

        var snapshot = Snapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.cellsViewModels as! [CellType.ViewModelType], toSection: .main)

        collectionViewDataSource.apply(snapshot, animatingDifferences: true)
    }

    open func createDataSource() -> DataSource {
        let cellProvider: DataSource.CellProvider = { [weak self] collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self?.cellsReusedIdentifier ?? "",
                                                          for: indexPath) as? CellType

            cell?.configure(with: itemIdentifier)

            return cell
        }

        return DataSource(collectionView: self, cellProvider: cellProvider)
    }

    open func applyChange(_ changes: [DefaultFiltersViewModel.Change]) {
        for change in changes {
            guard let cell = cellForItem(at: change.indexPath) else {
                continue
            }

            configure(filterCell: cell, cellViewModel: change.viewModel)
        }

        applySnapshot()
    }

    open func configure(filterCell: UICollectionViewCell, cellViewModel: FilterCellViewModelProtocol) {
        guard let cellViewModel = cellViewModel as? CellType.ViewModelType else { return }

        guard let configurableCell = filterCell as? CellType else { return }

        configurableCell.configure(with: cellViewModel)
    }
}
