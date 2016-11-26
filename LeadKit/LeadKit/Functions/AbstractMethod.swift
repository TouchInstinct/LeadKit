//
//  AbstractMethod.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public func abstractMethod(_ methodName: String = "Method") -> Never  {
    fatalError("\(methodName) has not been implemented")
}
