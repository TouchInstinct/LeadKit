//
//  TILog.swift
//  iOS-Base-Library
//
//  Created by Николай Ашанин on 24.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import CocoaLumberjack

public class TILog {
    
    /// Logger for CocoaLumberJack
    public var fileLogger: DDFileLogger
    
    init() {
        fileLogger = DDFileLogger.init()
        
        DDLog.addLogger(fileLogger)
        
        DDLog.addLogger(DDASLLogger.sharedInstance())
        DDLog.addLogger(DDTTYLogger.sharedInstance())
                        
        DDASLLogger.sharedInstance().logFormatter = TILogFormatter.init()
        DDTTYLogger.sharedInstance().logFormatter = TILogFormatter.init()
        
        let assertionHandler = NSAssertionHandler.init()
        
        NSThread.currentThread().threadDictionary.setValue(assertionHandler, forKey: NSAssertionHandlerKey)
    }
    
    /**
     Add start message for your application
     
     - returns: Return value looks like "AppName 1.0.1 session started on version 9.2 (build 13c75)"
     */
    public func startMessage() -> String {
        let app = TIApp.init()
        let startMessage = app.bundleName + " " + app.shortBundleVersion + "."
            + app.bundleVersion + " session started on "
            + NSProcessInfo.processInfo().operatingSystemVersionString.lowercaseString
        return startMessage
    }
    
}
