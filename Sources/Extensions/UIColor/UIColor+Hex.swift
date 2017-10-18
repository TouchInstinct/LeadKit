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

import UIKit

public extension UIColor {

    /**
     the shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.

     - parameter hex3:  Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let red     = CGFloat((hex3 & 0xF00) >> 8) / 0xF
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / 0xF
        let blue    = CGFloat((hex3 & 0x00F) >> 0) / 0xF
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     the shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.

     - parameter hex4: Four-digit hexadecimal value.
     */
    convenience init(hex4: UInt16) {
        let red     = CGFloat((hex4 & 0xF000) >> 12) / 0xF
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / 0xF
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / 0xF
        let alpha   = CGFloat((hex4 & 0x000F) >>  0) / 0xF

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     the six-digit hexadecimal representation of color of the form #RRGGBB.

     - parameter hex6:  Six-digit hexadecimal value.
     - parameter alpha: alpha: 0.0 - 1.0. The default is 1.0.
     */
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / 0xFF
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / 0xFF
        let blue    = CGFloat((hex6 & 0x0000FF) >>  0) / 0xFF

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     the six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.

     - parameter hex8: Eight-digit hexadecimal value.
     */
    convenience init(hex8: UInt32) {
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / 0xFF
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / 0xFF
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / 0xFF
        let alpha   = CGFloat((hex8 & 0x000000FF) >>  0) / 0xFF

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     convenience failable initializer which creates an instance with given hex color values if string has a correct format

     - parameter hexString: hex string with red green and blue values (can have `#` sign)
     - parameter alpha: alpha component used if not given in hexString
     */
    convenience init?(hexString: String, alpha: CGFloat = 1) {
        let hexStr: String

        if hexString.hasPrefix("#") {
            hexStr = String(hexString[hexString.index(hexString.startIndex, offsetBy: 1)...])
        } else {
            hexStr = hexString
        }

        let charactersCount = hexStr.characters.count

        switch charactersCount {
        case 3, 4:
            if let hex = UInt16(hexStr, radix: 16) {
                if charactersCount == 3 {
                    self.init(hex3: hex, alpha: alpha)
                } else {
                    self.init(hex4: hex)
                }
            } else {
                return nil
            }
        case 6, 8:
            if let hex = UInt32(hexStr, radix: 16) {
                if charactersCount == 6 {
                    self.init(hex6: hex, alpha: alpha)
                } else {
                    self.init(hex8: hex)
                }
            } else {
                return nil
            }
        default:
            return nil
        }
    }

}
