//
//  String+Localization.swift
//  LeadKit
//
//  Created by Николай Ашанин on 29.09.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension String {

    /**
     method returns localized string with default comment and self name

     - returns: localized string
     */
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

}
