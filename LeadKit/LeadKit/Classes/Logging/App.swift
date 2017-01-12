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
