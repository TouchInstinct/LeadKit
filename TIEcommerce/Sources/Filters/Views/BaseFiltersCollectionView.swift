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
open class BaseFiltersCollectionView<CellType: UICollectionViewCell & ConfigurableView,
                                     PropertyValue: FilterPropertyValueRepresenter & Hashable>: UICollectionView,
                                                                                                InitializableViewProtocol,
                                                                                                UpdatableView,
                                                                                                UICollectionViewDelegate where CellType.ViewModelType: FilterCellViewModelProtocol & Hashable {
    public enum DefaultSection: String {
        case main
    }

    public typealias DataSource = UICollectionViewDiffableDataSource<String, CellType.ViewModelType>
    public typealias Snapshot = NSDiffableDataSourceSnapshot<String, CellType.ViewModelType>

    public var layout: UICollectionViewLayout

    public weak var viewModel: BaseFilterViewModel<CellType.ViewModelType, PropertyValue>?

    public lazy var collectionViewDataSource = createDataSource()

    // MARK: - Init

    public init(layout: UICollectionViewLayout, viewModel: BaseFilterViewModel<CellType.ViewModelType, PropertyValue>? = nil) {
        self.layout = layout
        self.viewModel = viewModel

        super.init(frame: .zero, collectionViewLayout: layout)

        initializeView()
        viewDidLoad()
    }

    @available(*, unavailable)
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
        registerCell()

        viewModel?.filtersCollection = self
    }

    open func viewDidAppear() {
        applySnapshot()
    }

    // MARK: - UICollectionViewDelegate

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        let changes = viewModel.filterDidSelected(atIndexPath: indexPath)

        applyChange(changes)
    }

    // MARK: - UpdatableView

    open func updateView() {
        applySnapshot()
    }

    // MARK: - Open methods

    open func registerCell() {
        register(CellType.self, forCellWithReuseIdentifier: CellType().reuseIdentifier ?? "")
    }

    open func applySnapshot() {
        guard let viewModel = viewModel else {
            return
        }

        var snapshot = Snapshot()

        snapshot.appendSections([DefaultSection.main.rawValue])
        snapshot.appendItems(viewModel.cellsViewModels, toSection: DefaultSection.main.rawValue)

        collectionViewDataSource.apply(snapshot, animatingDifferences: true)
    }

    open func createDataSource() -> DataSource {
        let cellProvider: DataSource.CellProvider = {collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType().reuseIdentifier ?? "",
                                                          for: indexPath) as? CellType

            cell?.configure(with: itemIdentifier)

            return cell
        }

        return DataSource(collectionView: self, cellProvider: cellProvider)
    }

    open func applyChange(_ changes: [BaseFilterViewModel<CellType.ViewModelType, PropertyValue>.Change]) {
        for change in changes {
            guard let cell = cellForItem(at: change.indexPath) as? CellType else {
                continue
            }

            cell.configure(with: change.viewModel)
        }
    }
}
