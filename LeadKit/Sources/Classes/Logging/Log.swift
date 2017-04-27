//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import CocoaLumberjack

open class Log {

    public init() {
        DDLog.add(DDFileLogger())

        DDLog.add(DDASLLogger.sharedInstance)
        DDLog.add(DDTTYLogger.sharedInstance)

        let logFormatter = LogFormatter()

        DDASLLogger.sharedInstance.logFormatter = logFormatter
        DDTTYLogger.sharedInstance.logFormatter = logFormatter

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
