//
//  UIColor+Hex.swift
//  LeadKit
//
//  Created by Ivan Smolin on 07/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIColor {

    /**
     convenience initializer which creates an instance with given hex color values

     - parameter hex:   hex with red, green and blue values
     - parameter alpha: alpha component

     - returns: new instance with given hex color
     */
    public convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((hex & 0x00FF00) >>  8) / 0xFF
        let blue  = CGFloat((hex & 0x0000FF) >>  0) / 0xFF

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     convenience failable initializer which creates an instance with given hex color values if string has a correct format

     - parameter hexString: hex string with red green and blue values (can have `#` sign)
     - parameter alpha: alpha component

     - returns: new instance with given hex color or nil if hexString is incorrect
     */
    public convenience init?(hexString: String, alpha: CGFloat = 1) {
        let hexStringWithoutHash = hexString.stringByReplacingOccurrencesOfString("#", withString: "",
                                                                                  options: .LiteralSearch, range: nil)
        if let hex = UInt32(hexStringWithoutHash, radix: 16) {
            self.init(hex: hex, alpha: alpha)
        } else {
            return nil
        }
    }

}
