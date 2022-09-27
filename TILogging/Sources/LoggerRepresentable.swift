import os

public protocol LoggerRepresentable {
    func log(_ message: StaticString, log: OSLog?, type: OSLogType, _ arguments: CVarArg...)
}
