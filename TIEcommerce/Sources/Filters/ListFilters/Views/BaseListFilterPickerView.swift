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

import TISwiftUtils
import TIUIElements
import TIUIKitCore
import UIKit

@available(iOS 13.0, *)
open class BaseFiltersTableView<CellType: UITableViewCell & ConfigurableView,
                                PropertyValue: FilterPropertyValueRepresenter & Hashable>:
                                    UITableView,
                                    InitializableViewProtocol,
                                    Updatable,
                                    UITableViewDelegate where CellType.ViewModelType: FilterCellViewModelProtocol & Hashable {

    public enum DefaultSection: String {
        case main
    }

    public typealias DataSource = UITableViewDiffableDataSource<String, CellType.ViewModelType>
    public typealias Snapshot = NSDiffableDataSourceSnapshot<String, CellType.ViewModelType>

    public weak var viewModel: BaseFilterViewModel<CellType.ViewModelType, PropertyValue>?

    public lazy var tableViewDataSource = createDataSource()

    // MARK: - Init

    public init(viewModel: BaseFilterViewModel<CellType.ViewModelType, PropertyValue>, allowsMultipleSelection: Bool = true) {
        self.viewModel = viewModel

        super.init(frame: .zero, style: .plain)

        initializeView()
        viewDidLoad()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    // MARK: - Life cycle

    open func addViews() {
        // override in subclass
    }

    open func configureLayout() {
        // override in subclass
    }

    open func bindViews() {
        delegate = self
    }

    open func configureAppearance() {
        alwaysBounceVertical = false
        allowsMultipleSelection = allowsMultipleSelection

//        reloadData(with: viewModel?.visibleSelectedIndexes ?? [])
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
        filterDidTapped(atIndexPath: indexPath)
    }

    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        filterDidTapped(atIndexPath: indexPath)
    }

    // MARK: - UpdatableView

    open func update() {
        applySnapshot()
    }

    // MARK: - Open methods

    open func registerCell() {
        register(CellType.self, forCellReuseIdentifier: CellType.reuseIdentifier)
    }

    open func filterDidTapped(atIndexPath indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        let changes = viewModel.filterDidSelected(atIndexPath: indexPath)

        applyChange(changes)
    }

    open func applySnapshot() {
        guard let viewModel = viewModel else {
            return
        }

        var snapshot = Snapshot()

        snapshot.appendSections([DefaultSection.main.rawValue])
        snapshot.appendItems(viewModel.cellsViewModels, toSection: DefaultSection.main.rawValue)

        tableViewDataSource.apply(snapshot, animatingDifferences: true)
    }

    open func createDataSource() -> DataSource {
        let cellProvider: DataSource.CellProvider = { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier, for: indexPath) as? CellType

            cell?.configure(with: itemIdentifier)

            return cell
        }

        return DataSource(tableView: self, cellProvider: cellProvider)
    }

    open func applyChange(_ changes: [BaseFilterViewModel<CellType.ViewModelType, PropertyValue>.Change]) {
        changes.forEach { change in
            guard let cell = cellForRow(at: change.indexPath) as? CellType else {
                return
            }

            cell.configure(with: change.viewModel)

            change.viewModel.isSelected
                ? selectRow(at: change.indexPath, animated: false, scrollPosition: ScrollPosition.none)
                : deselectRow(at: change.indexPath, animated: false)
        }
    }
}
