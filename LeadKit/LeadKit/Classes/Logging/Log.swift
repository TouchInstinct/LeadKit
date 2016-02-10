//
//  Log.swift
//  LeadKit
//
//  Created by Николай Ашанин on 24.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

public class Log {

    /// Logger for CocoaLumberJack
    public let fileLogger = DDFileLogger()

    init() {

        DDLog.addLogger(fileLogger)

        DDLog.addLogger(DDASLLogger.sharedInstance())
        DDLog.addLogger(DDTTYLogger.sharedInstance())

        DDASLLogger.sharedInstance().logFormatter = LogFormatter()
        DDTTYLogger.sharedInstance().logFormatter = LogFormatter()

        let assertionHandler = NSAssertionHandler()

        NSThread.currentThread().threadDictionary.setValue(assertionHandler, forKey: NSAssertionHandlerKey)
    }

    /**
     Add start message for your application

     - returns: Return value looks like "AppName 1.0.1 session started on version 9.2 (build 13c75)"
     */
    public static func startMessage() -> String {
        let startMessage = App.bundleName + " " + App.shortVersion + "."
            + App.bundleVersion + " session started on "
            + NSProcessInfo.processInfo().operatingSystemVersionString.lowercaseString
        return startMessage
    }

}