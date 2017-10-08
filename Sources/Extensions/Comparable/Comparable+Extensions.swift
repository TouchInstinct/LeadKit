//
//  Comparable+Extensions.swift
//  LeadKit iOS
//
//  Created by Igor Kislyuk on 08/10/2017.
//  Copyright © 2017 Touch Instinct. All rights reserved.
//

import Foundation

extension Comparable {

    func `in`(bounds: (lower: Self, upper: Self)) -> Self {
        return min(max(bounds.lower, self), bounds.upper)
    }

}
