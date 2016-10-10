//
//  LogFormatter.swift
//  LeadKit
//
//  Created by Николай Ашанин on 24.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import CocoaLumberjack
import CocoaLumberjack.DDDispatchQueueLogFormatter

class LogFormatter: DDDispatchQueueLogFormatter {
    fileprivate let dateFormatter: DateFormatter

    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.formatterBehavior = .behavior10_4
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"

        super.init()
    }

    override func format(message logMessage: DDLogMessage) -> String {
        let level: String

        switch logMessage.flag {
        case DDLogFlag.error:
            level = "ERR"
        case DDLogFlag.warning:
            level = "WRN"
        case DDLogFlag.info:
            level = "INF"
        case DDLogFlag.debug:
            level = "DBG"
        default:
            level = "VRB"
        }

        let dateAndTime = dateFormatter.string(from: logMessage.timestamp)
        return "\(level) \(dateAndTime) [\(logMessage.fileName):\(logMessage.line)]: \(logMessage.message)"
    }

}
