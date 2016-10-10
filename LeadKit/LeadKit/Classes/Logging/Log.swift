//
//  Log.swift
//  LeadKit
//
//  Created by Николай Ашанин on 24.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import CocoaLumberjack

open class Log {

    /// Logger for CocoaLumberJack
    open let fileLogger = DDFileLogger()

    init() {
        DDLog.add(fileLogger)

        DDLog.add(DDASLLogger.sharedInstance())
        DDLog.add(DDTTYLogger.sharedInstance())

        let logFormatter = LogFormatter()

        DDASLLogger.sharedInstance().logFormatter = logFormatter
        DDTTYLogger.sharedInstance().logFormatter = logFormatter

        let assertionHandler = NSAssertionHandler()

        Thread.current.threadDictionary.setValue(assertionHandler, forKey: NSAssertionHandlerKey)
    }

    /**
     Add start message for your application

     - returns: Return value looks like "AppName 1.0.1 session started on version 9.2 (build 13c75)"
     */
    open static var startMessage: String {
        let startMessage = App.bundleName + " " + App.shortVersion + "."
            + App.bundleVersion + " session started on "
            + ProcessInfo.processInfo.operatingSystemVersionString.lowercased()
        return startMessage
    }

}
