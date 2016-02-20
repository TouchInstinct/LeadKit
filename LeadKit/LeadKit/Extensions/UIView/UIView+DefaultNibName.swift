//
//  UIView+DefaultNibName.swift
//  LeadKit
//
//  Created by Иван Смолин on 10/02/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension UIView: StaticNibNameProtocol {
    /**
     default implementation of StaticNibNameProtocol
     
     - returns: class name string without dot (last class path component)
     */
    
    public class func nibName() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
}
