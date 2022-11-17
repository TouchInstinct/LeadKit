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
import UIKit
import OSLog

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

    private let logsManipulator: LogsListManipulatorProtocol

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

    public var fileCreator: FileCreator?
    weak public var logsListView: LogsListViewOutput?

    public init(logsManipulator: LogsListManipulatorProtocol? = nil) {
        self.logsManipulator = logsManipulator ?? DefaultLogsListManipulator()
    }

    @MainActor
    open func loadLogs(preCompletion: VoidClosure? = nil, postCompletion: VoidClosure? = nil) async {
        allLogs = []
        logsListView?.setLoadingState()
        preCompletion?()

        if case let .success(logs) = await logsManipulator.fetchLogs() {
            allLogs = logs
        }

        logsListView?.setNormalState()
        postCompletion?()
    }

    open func filterLogs(filter: Closure<OSLogEntryLog, Bool>? = nil) {
        filteredLogs = allLogs.filter { filter?($0) ?? true }
    }

    @MainActor
    open func filterLogs(byText text: String) async {
        guard !text.isEmpty else {
            filteredLogs = allLogs
            return
        }

        logsListView?.startSearch()

        let localFilteredLogs = await logsManipulator.filter(allLogs, byText: text)

        filteredLogs = localFilteredLogs
        logsListView?.stopSearch()
    }

    open func getFileWithLogs() -> URL? {
        guard let data = encodeLogs() else {
            return nil
        }

        if case let .success(url) = fileCreator?.createFile(withData: data) {
            return url
        }

        return nil
    }

    public func encodeLogs() -> Data? {
        filteredLogs
            .map { $0.getDescription() }
            .joined(separator: "\n\n")
            .data(using: .utf8)
    }

    open func actionHandler(for action: UIAction) {
        guard let level = LevelType(rawValue: action.title) else { return }

        switch level {
        case .all:
            filterLogs()

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

@available(iOS 15, *)
private extension OSLogEntryLog {
    func getDescription() -> String {
        return "[\(date)] - [\(category)]: \(composedMessage)"
    }
}
