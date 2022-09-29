import TISwiftUtils
import UIKit
import OSLog

public protocol LogsListViewOutput: AnyObject {
    func reloadTableView()
}

@available(iOS 15, *)
open class LogsStorageViewModel {

    public enum LevelType: String, CaseIterable {
        case all
        case `default`
        case info
        case debug
        case error
        case fault
    }

    private var allLogs: [OSLogEntryLog] = [] {
        didSet {
            filterLogs()
        }
    }

    public var filteredLogs: [OSLogEntryLog] = [] {
        didSet {
            logsListView?.reloadTableView()
        }
    }

    weak public var logsListView: LogsListViewOutput?

    public init() {
        loadLogs()
    }

    open func loadLogs() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let logStore = try? OSLogStore(scope: .currentProcessIdentifier)
            let entries = try? logStore?.getEntries()

            let logs =  entries?
                .compactMap { $0 as? OSLogEntryLog }

            DispatchQueue.main.async {
                self?.allLogs = logs ?? []
            }
        }
    }

    open func filterLogs(filter: Closure<OSLogEntryLog, Bool>? = nil) {
        filteredLogs = allLogs.filter { filter?($0) ?? true }
    }

    open func actionHandler(for action: UIAction) {
        guard let level = LevelType(rawValue: action.title) else { return }

        switch level {
        case .all:
            loadLogs()

        case .info:
            filterLogs(filter: { $0.level == .info })

        case .default:
            filterLogs(filter: { $0.level == .notice })

        case .debug:
            filterLogs(filter: { $0.level == .debug })

        case .error:
            filterLogs(filter: { $0.level == .error })

        case .fault:
            filterLogs(filter: { $0.level == .fault })
        }
    }
}
