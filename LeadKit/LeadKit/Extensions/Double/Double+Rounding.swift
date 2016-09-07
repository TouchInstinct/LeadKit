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
     rounds double value 1.7800000004 to 1.78

     - parameter val:       value for rounding
     - parameter persicion: important number of digits after comma

     - returns: rounded value
     */
    public func roundValue(withPersicion persicion: UInt) -> Double {
        let divider = pow(10.0, Double(persicion - 1))

        return round(self * divider) / divider
    }

}
