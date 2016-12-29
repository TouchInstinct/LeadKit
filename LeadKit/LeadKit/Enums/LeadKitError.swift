//
//  LeadKitError.swift
//  LeadKit
//
//  Created by Ivan Smolin on 26/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// Enum which represents common errors in LeadKit framework
///
/// - failedToCastValue: attempt to cast was failed
public enum LeadKitError: Error {

    case failedToCastValue(expectedType: Any.Type, givenType: Any.Type)

}
