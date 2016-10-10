//
//  Any+TypeName.swift
//  LeadKit
//
//  Created by Ivan Smolin on 06/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public func className<T>(of type: T) -> String {
    let clsName = String(describing: type(of: type))

    if let typeRange = clsName.range(of: ".Type") {
        return clsName.substring(to: typeRange.lowerBound)
    } else {
        return clsName
    }
}
