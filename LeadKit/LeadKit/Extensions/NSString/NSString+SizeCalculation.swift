//
//  NSString+SizeCAlculation.swift
//  LeadKit
//
//  Created by Иван Смолин on 21/03/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension NSString {

    /**
     method which calculates string height based on given width and character attributes

     - parameter width:      maximum width of string
     - parameter attributes: dictionary with string character attributes

     - returns: string height
     */
    public func heightWith(width: CGFloat, attributes: [String: AnyObject]?) -> CGFloat {
        return self.boundingRectWithSize(CGSize(width: width, height: CGFloat.max),
                                         options: [.UsesLineFragmentOrigin, .UsesFontLeading],
                                         attributes: attributes,
                                         context: nil).size.height
    }

    /**
     method which calculates required number of lines to fit string with given width and character attributes

     - parameter width:      maximum width of string
     - parameter attributes: dictionary with string character attributes

     - returns: minimum number of lines
     */
    public func numberOfLinesWith(width: CGFloat, attributes: [String: AnyObject]) -> UInt {
        guard let font = attributes[NSFontAttributeName] as? UIFont else {
            preconditionFailure("Value for NSFontAttributeName should be defined in attributes")
        }

        let lineHeight = font.lineHeight

        let lineHeightRounded = Double(lineHeight).roundValue(withPersicion: 2)

        let height = heightWith(width, attributes: attributes)

        let heightRounded = Double(height).roundValue(withPersicion: 2)

        let numberOfLines = ceil(heightRounded / lineHeightRounded)

        return UInt(numberOfLines)
    }

    /**
     method which calculates string width based on given character attributes

     - parameter attriutes: dictionary with string character attributes

     - returns: string width
     */
    public func widthWith(attriutes: [String: AnyObject]) -> CGFloat {
        return CGFloat(ceil(Double(sizeWithAttributes(attriutes).width)))
    }

    /**
     method which calculates text size based on given character attributes

     - parameter width:      maximum width of text
     - parameter height:     maximum height of text
     - parameter attributes: dictionary with string character attributes

     - returns: text size
     */
    public func sizeWith(maxWidth width: CGFloat = CGFloat.max,
                                  maxHeight height: CGFloat = CGFloat.max,
                                            attributes: [String: AnyObject]?) -> CGSize {

        return boundingRectWithSize(CGSize(width: width, height: height),
                                    options: .UsesLineFragmentOrigin,
                                    attributes: attributes,
                                    context: nil).size
    }
    
}
