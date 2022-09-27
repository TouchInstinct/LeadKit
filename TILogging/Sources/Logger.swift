import os

public struct TILogger: LoggerRepresentable {

    // MARK: - Properties

    public static let defaultLogger = TILogger(subsystem: .defaultSubsystem ?? "", category: .pointsOfInterest)

    public let logInfo: OSLog

    // MARK: - Init

    public init(subsystem: String, category: String) {
        self.logInfo = .init(subsystem: subsystem, category: category)
    }

    public init(subsystem: String, category: OSLog.Category) {
        self.logInfo = .init(subsystem: subsystem, category: category)
    }

    // MARK: - LoggerRepresentable

    public func log(_ message: StaticString, log: OSLog?, type: OSLogType, _ arguments: CVarArg...) {
        os_log(message, log: log ?? logInfo, type: type, arguments)
    }

    // MARK: - Public methods

    public func verbose(_ message: StaticString, _ arguments: CVarArg...) {
        self.log(message, log: logInfo, type: .default, arguments)
    }

    public func info(_ message: StaticString, _ arguments: CVarArg...) {
        self.log(message, log: logInfo, type: .info, arguments)
    }

    public func debug(_ message: StaticString, _ arguments: CVarArg...) {
        self.log(message, log: logInfo, type: .debug, arguments)
    }

    public func error(_ message: StaticString, _ arguments: CVarArg...) {
        self.log(message, log: logInfo, type: .error, arguments)
    }

    public func fault(_ message: StaticString, _ arguments: CVarArg...) {
        self.log(message, log: logInfo, type: .fault, arguments)
    }
}

private extension String {
    static let defaultSubsystem = Bundle.main.bundleIdentifier
}
