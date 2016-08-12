//
//  UIView+DefaultReuseIdentifier.swift
//  LeadKit
//
//  Created by Ivan Smolin on 26/07/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension UIView: ReuseIdentifierProtocol {

    /**
     default implementation of ReuseIdentifierProtocol

     - returns: type name string
     */
    public class func reuseIdentifier() -> String {
        return String(self.dynamicType)
    }

}
