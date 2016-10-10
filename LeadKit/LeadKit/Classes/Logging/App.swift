//
//  App.swift
//  LeadKit
//
//  Created by Николай Ашанин on 24.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

open class App {

    fileprivate static let stringVendorIdentifierKey = "stringIdentifierForVendor"
    /// The value of CFBundleName
    open static let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    /// The value of CFBundleShortVersionString
    open static let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    /// The value of CFBundleVersion
    open static let bundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""

    /**
     Return app's version
     - returns: shortBundleVersion.bundleVersion
     */
    open static var version: String {
        return App.shortVersion + "." + App.bundleVersion
    }

    /**
     Return device identifier
     - returns: UUIDString
     */
    open static var deviceUniqueIdentifier: String {
        if let vendorIdentifier = UserDefaults.standard.string(forKey: App.stringVendorIdentifierKey) {
            return vendorIdentifier
        }

        let vendorIdentifier = UUID().uuidString
        UserDefaults.standard.set(vendorIdentifier, forKey: App.stringVendorIdentifierKey)
        UserDefaults.standard.synchronize()

        return vendorIdentifier
    }

}
