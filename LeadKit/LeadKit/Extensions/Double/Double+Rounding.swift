//
//  Double+Rounding.swift
//  LeadKit
//
//  Created by Ivan Smolin on 07/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public extension Double {

    /**
     rounds double value 1.7860000004 to 1.79

     - parameter val:       value for rounding
     - parameter persicion: important number of digits after comma

     - returns: rounded value
     */
    public func roundValue(withPersicion persicion: UInt) -> Double {
        let divider = pow(10.0, Double(persicion))

        return round(self * divider) / divider
    }

    /**
     discard dractional part double value 1.7860000004 to 1.78

     - parameter val:       value for discarding dractional part
     - parameter persicion: important number of digits after comma

     - returns: value with discarded dractional part
     */
    func discardFractionalTo(number: Int) -> Double {
        let divider = pow(10.0, Double(number))
        let roundedNumber = Double(Int(self * divider)) / divider
        return roundedNumber
    }

}
