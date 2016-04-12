//
//  NSIndexPath+ImmutableIndexPath.swift
//  LeadKit
//
//  Created by Иван Смолин on 21/03/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

// http://stackoverflow.com/a/21686163

extension NSIndexPath {
    /**
     method which check instance class and create immutable copy if class is not NSIndexPath
     
     - returns: immutable NSIndexPath instance
     */
    
    func immutableIndexPath() -> NSIndexPath {
        if Mirror(reflecting: self).subjectType == NSIndexPath.self {  // check for UIMutableIndexPath
            return self
        }
        
        return NSIndexPath(forItem: self.item, inSection: self.section)
    }
    
}
