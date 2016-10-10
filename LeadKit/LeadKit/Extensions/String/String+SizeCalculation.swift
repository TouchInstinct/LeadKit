//
//  String+SizeCalculation.swift
//  LeadKit
//
//  Created by Иван Смолин on 21/03/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

/**
 *  Struct for holding result of string size calculation
 */
public struct StringSizeCalculationResult {

    public let size: CGSize
    public let fontLineHeight: CGFloat?

}

public extension StringSizeCalculationResult {

    public var height: CGFloat { return size.height }

    public var width: CGFloat { return size.width }

    public var numberOfLines: UInt? {
        if let lineHeight = fontLineHeight {
            let lineHeightRounded = Double(lineHeight).roundValue(withPersicion: 2)

            let heightRounded = Double(height).roundValue(withPersicion: 2)

            let numberOfLines = ceil(heightRounded / lineHeightRounded)

            return UInt(numberOfLines)
        }

        return nil
    }

}

public extension String {

    /**
     method which calculates string size based on given character attributes and (optional) max width and height

     - parameter attributes: dictionary with string character attributes
     - parameter maxWidth:   maximum width of text
     - parameter maxHeight:  maximum height of text

     - returns: string size calculation result
     */
    public func size(withAttributes attributes: [String: AnyObject]?,
                                    maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude,
                                    maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude) -> StringSizeCalculationResult {

        let size = self.boundingRect(with: CGSize(width: maxWidth, height: maxHeight),
                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                             attributes: attributes,
                                             context: nil).size

        let fontLineHeight = (attributes?[NSFontAttributeName] as? UIFont)?.lineHeight
        
        return StringSizeCalculationResult(size: size, fontLineHeight: fontLineHeight)
    }
    
}
