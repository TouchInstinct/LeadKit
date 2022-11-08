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

import Foundation
import os

public struct TILogger: LoggerRepresentable {

    // MARK: - Properties

    @available(iOS 12, *)
    public static let defaultLogger = TILogger(subsystem: .defaultSubsystem ?? "", category: .pointsOfInterest)

    public let logInfo: NSLog

    // MARK: - Init

    public init(subsystem: String, category: String) {
        self.logInfo = .init(subsystem: subsystem, category: category)
    }

    @available(iOS 12, *)
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
