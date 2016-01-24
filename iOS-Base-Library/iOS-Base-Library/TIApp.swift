//
//  TIApp.swift
//  iOS-Base-Library
//
//  Created by Николай Ашанин on 24.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import UIKit

public class TIApp {
    private let stringVendorIdentifierKey: String = "stringIdentifierForVendor"
    /// The value of CFBundleName
    public var bundleName: String
    /// The value of CFBundleShortVersionString
    public var shortBundleVersion: String
    /// The value of CFBundleVersion
    public var bundleVersion: String
    init() {
        bundleName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String

        shortBundleVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        bundleVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
    }
    /**
     Return app's version
     - returns: shortBundleVersion.bundleVersion
     */
    public func version() -> String {
        return shortBundleVersion + "." + bundleVersion
    }

    /**
     Return device identifier
     - returns: UUIDString
     */
    public func stringIdentifierForVendor() -> String {
        var returnValue = NSUserDefaults.standardUserDefaults().stringForKey(stringVendorIdentifierKey)
        if (returnValue == nil) {
            returnValue = NSUUID().UUIDString
            NSUserDefaults.standardUserDefaults().setObject(returnValue, forKey: stringVendorIdentifierKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        return returnValue!
    }

}
