//
//  UIViewController+DefaultStoryboardIdentifier.swift
//  LeadKit
//
//  Created by Ivan Smolin on 06/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension UIViewController: StoryboardIdentifierProtocol {

    /**
     default implementation of StoryboardIdentifierProtocol

     - returns: type name string
     */
    open class var storyboardIdentifier: String {
        return className(of: self)
    }
    
}
