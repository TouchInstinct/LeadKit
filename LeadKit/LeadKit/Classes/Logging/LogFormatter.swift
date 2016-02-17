//
//  LogFormatter.swift
//  LeadKit
//
//  Created by Николай Ашанин on 24.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift
import CocoaLumberjack.DDDispatchQueueLogFormatter

class LogFormatter: DDDispatchQueueLogFormatter {
    let dateFormatter: NSDateFormatter

    override init() {
        dateFormatter = NSDateFormatter()
        dateFormatter.formatterBehavior = .Behavior10_4
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"

        super.init()
    }

    override func formatLogMessage(logMessage: DDLogMessage!) -> String {
        var level: String!

        switch logMessage.flag {
        case DDLogFlag.Error:
            level = "ERR"
        case DDLogFlag.Warning:
            level = "WRN"
        case DDLogFlag.Info:
            level = "INF"
        case DDLogFlag.Debug:
            level = "DBG"
        default:
            level = "VRB"
        }

        let dateAndTime = dateFormatter.stringFromDate(logMessage.timestamp)
        return "\(level) \(dateAndTime) [\(logMessage.fileName):\(logMessage.line)]: \(logMessage.message)"
    }

}
