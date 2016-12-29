//
//  Any+Cast.swift
//  LeadKit
//
//  Created by Ivan Smolin on 26/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// Function which attempts to cast given value to specific type
///
/// - Parameter value: value to cast
/// - Returns: value casted to specific type
/// - Throws: LeadKitError.failedToCastValue cast fails
public func cast<T>(_ value: Any?) throws -> T {
    guard let val = value as? T else {
        throw LeadKitError.failedToCastValue(expectedType: T.self, givenType: type(of: value))
    }

    return val
}
