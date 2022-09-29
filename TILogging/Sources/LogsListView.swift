import TIUIKitCore
import OSLog
import UIKit

@available(iOS 15, *)
open class LogsListView: BaseInitializeableViewController, LogsListViewOutput {

    public enum TableSection: String, Hashable {
        case main
    }

    private let searchView = UITextField()
    private let segmentView = UISegmentedControl()
    private let tableView = UITableView()

    lazy private var dataSource = createDataSource()

    public typealias DataSource = UITableViewDiffableDataSource<String, OSLogEntryLog>
    public typealias Snapshot = NSDiffableDataSourceSnapshot<String, OSLogEntryLog>

    public let viewModel = LogsStorageViewModel()

    // MARK: - Life cycle

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        applySnapshot()
    }

    open override func addViews() {
        super.addViews()

        view.addSubview(searchView)
        view.addSubview(segmentView)
        view.addSubview(tableView)
    }

    open override func configureLayout() {
        super.configureLayout()

        [searchView, segmentView, tableView]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchView.heightAnchor.constraint(equalToConstant: 32),

            segmentView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            segmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentView.heightAnchor.constraint(equalToConstant: 32),

            tableView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    open override func bindViews() {
        super.bindViews()

        viewModel.logsListView = self
        tableView.register(LogEntryTableViewCell.self, forCellReuseIdentifier: "identifier")
    }

    open override func configureAppearance() {
        super.configureAppearance()

        configureSegmentView()
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
    }

    // MARK: - LogsListViewOutput

    open func reloadTableView() {
        applySnapshot()
    }

    // MARK: - Open methods

    open func createDataSource() -> DataSource {
        let cellProvider: DataSource.CellProvider = { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withIdentifier: "identifier",
                                                          for: indexPath) as? LogEntryTableViewCell

            cell?.configure(with: itemIdentifier)

            return cell
        }

        return .init(tableView: tableView, cellProvider: cellProvider)
    }

    open func applySnapshot() {
        var snapshot = Snapshot()

        snapshot.appendSections([TableSection.main.rawValue])
        snapshot.appendItems(viewModel.filteredLogs, toSection: TableSection.main.rawValue)

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Private methods

    private func configureSegmentView() {
        for (index, segment) in LogsStorageViewModel.LevelType.allCases.enumerated() {
            let action = UIAction(title: segment.rawValue, handler: viewModel.actionHandler(for:))
            segmentView.insertSegment(action: action, at: index, animated: false)
        }

        segmentView.selectedSegmentIndex = 0
    }
}
