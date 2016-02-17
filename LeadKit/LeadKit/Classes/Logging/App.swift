//
//  App.swift
//  LeadKit
//
//  Created by Николай Ашанин on 24.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public class App {
    private static let stringVendorIdentifierKey = "stringIdentifierForVendor"
    /// The value of CFBundleName
    public static let bundleName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
    /// The value of CFBundleShortVersionString
    public static let shortVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
    /// The value of CFBundleVersion
    public static let bundleVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String

    /**
     Return app's version
     - returns: shortBundleVersion.bundleVersion
     */
    public static func version() -> String {
        return App.shortVersion + "." + App.bundleVersion
    }

    /**
     Return device identifier
     - returns: UUIDString
     */
    public static func stringIdentifierForVendor() -> String {
        var returnValue = NSUserDefaults.standardUserDefaults().stringForKey(App.stringVendorIdentifierKey)
        if returnValue == nil {
            returnValue = NSUUID().UUIDString
            NSUserDefaults.standardUserDefaults().setObject(returnValue, forKey: App.stringVendorIdentifierKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        return returnValue!
    }

}
