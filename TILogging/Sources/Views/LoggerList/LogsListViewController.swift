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
import TIUIKitCore
import OSLog
import UIKit

@available(iOS 15, *)
open class LogsListViewController: BaseInitializeableViewController,
                         LogsListViewOutput,
                         AlertPresentationContext,
                         UISearchBarDelegate,
                         UITextFieldDelegate {

    private var timer: Timer?

    public enum TableSection: String, Hashable {
        case main
    }

    public let activityView = UIActivityIndicatorView()
    public let searchView = UISearchBar()
    public let segmentView = UISegmentedControl()
    public let refreshControl = UIRefreshControl()
    public let shareButton = UIButton()
    public let tableView = UITableView()

    lazy private var dataSource = createDataSource()

    public typealias DataSource = UITableViewDiffableDataSource<String, OSLogEntryLog>
    public typealias Snapshot = NSDiffableDataSourceSnapshot<String, OSLogEntryLog>

    public let viewModel = LogsStorageViewModel()

    // MARK: - Life cycle

    open override func viewDidLoad() {
        super.viewDidLoad()

        loadLogs()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        applySnapshot()
    }

    open override func addViews() {
        super.addViews()

        tableView.addSubview(refreshControl)

        view.addSubviews(searchView,
                         segmentView,
                         shareButton,
                         tableView,
                         activityView)
    }

    open override func configureLayout() {
        super.configureLayout()

        [searchView, segmentView, shareButton, tableView, activityView]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchView.heightAnchor.constraint(equalToConstant: 32),

            segmentView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8),
            segmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentView.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -8),
            segmentView.heightAnchor.constraint(equalToConstant: 32),

            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            shareButton.centerYAnchor.constraint(equalTo: segmentView.centerYAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 32),
            shareButton.widthAnchor.constraint(equalToConstant: 32),

            tableView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            activityView.heightAnchor.constraint(equalToConstant: 32),
            activityView.widthAnchor.constraint(equalToConstant: 32),
        ])
    }

    open override func bindViews() {
        super.bindViews()

        viewModel.logsListView = self
        searchView.delegate = self
        tableView.register(LogEntryTableViewCell.self, forCellReuseIdentifier: "identifier")
        refreshControl.addTarget(self, action: #selector(reloadLogs), for: .valueChanged)
        shareButton.addTarget(self, action: #selector(shareLogs), for: .touchUpInside)
    }

    open override func configureAppearance() {
        super.configureAppearance()

        configureSegmentView()
        configureReloadButton()
        configureSearchView()

        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
    }

    // MARK: - LogsListViewOutput

    open func reloadTableView() {
        applySnapshot()
    }

    open func setLoadingState() {
        view.subviews.forEach { $0.isUserInteractionEnabled = false }
        startLoadingAnimation()
    }

    open func setNormalState() {
        view.subviews.forEach { $0.isUserInteractionEnabled = true }
        stopLoadingAnimation()
    }

    open func startSearch() {
        [shareButton, segmentView, tableView]
            .forEach { $0.isUserInteractionEnabled = false }
        startLoadingAnimation()
    }

    open func stopSearch() {
        [shareButton, segmentView, tableView]
            .forEach { $0.isUserInteractionEnabled = true }
        stopLoadingAnimation()
    }

    // MARK: - UISearchBarDelegate + UITextFieldDelegate

    open func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterLogsByText()
            return
        }

        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 3,
                                     target: self,
                                     selector: #selector(filterLogsByText),
                                     userInfo: nil,
                                     repeats: false)
    }

    open func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        searchView.resignFirstResponder()
    }

    open func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.fileCreator = .init(fileName: textField.text ?? "", fileExtension: "log")
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

    open func startLoadingAnimation() {
        activityView.isHidden = false
        activityView.startAnimating()
    }

    open func stopLoadingAnimation() {
        activityView.isHidden = true
        activityView.stopAnimating()
    }

    // MARK: - Private methods

    private func configureSegmentView() {
        for (index, segment) in LogsStorageViewModel.LevelType.allCases.enumerated() {
            let action = UIAction(title: segment.rawValue, handler: viewModel.actionHandler(for:))
            segmentView.insertSegment(action: action, at: index, animated: false)
        }

        segmentView.selectedSegmentIndex = 0
    }

    private func configureReloadButton() {
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
    }

    private func configureSearchView() {
        searchView.placeholder = "Date, subcategory, message text, etc."
        searchView.layer.backgroundColor = UIColor.systemBackground.cgColor
        searchView.searchBarStyle = .minimal
    }

    private func startSharingFlow() {
        let alert = AlertFactory().alert(title: "Enter file name", actions: [
            .init(title: "Cancel", style: .cancel, action: nil),
            .init(title: "Share", style: .default, action: { [weak self] in
                self?.presentShareScreen()
            })
        ])

        alert.present(on: self, alertViewFactory: { configuration in
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
                .configured(with: configuration)

            alertController.addTextField(configurationHandler: { textField in
                textField.delegate = self
            })

            return alertController
        })
    }

    private func presentShareScreen() {
        guard let file = viewModel.getFileWithLogs() else {
            AlertFactory().retryAlert(title: "Can't create a file with name: {\(viewModel.fileCreator?.fullFileName ?? "")}",
                                      retryAction: { [weak self] in
                self?.startSharingFlow()
            }).present(on: self)
            return 
        }

        let activityViewController = UIActivityViewController(activityItems: [file], 
                                                              applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    private func loadLogs(preCompletion: VoidClosure? = nil, postCompletion: VoidClosure? = nil) {
        Task {
            await viewModel.loadLogs(preCompletion: preCompletion, postCompletion: postCompletion)
        }
    }

    // MARK: - Actions

    @objc private func reloadLogs() {
        loadLogs(preCompletion: stopLoadingAnimation, postCompletion: refreshControl.endRefreshing)
    }

    @objc private func shareLogs() {
        startSharingFlow()
    }

    @objc private func filterLogsByText() {
        Task {
            await viewModel.filterLogs(byText: searchView.text ?? "")
        }
    }
}
