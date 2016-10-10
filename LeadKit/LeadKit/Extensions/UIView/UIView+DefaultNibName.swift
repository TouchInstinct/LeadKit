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

     - returns: class name string
     */
    open class var nibName: String {
        return className(of: self)
    }
    
}
