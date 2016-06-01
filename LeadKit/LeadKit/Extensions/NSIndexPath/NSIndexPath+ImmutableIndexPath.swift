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
        /// return immutable copy if class is not NSIndexPath or return self
    var immutableIndexPath: NSIndexPath {
        if Mirror(reflecting: self).subjectType == NSIndexPath.self {  // check for UIMutableIndexPath
            return self
        }
        
        return NSIndexPath(forItem: item, inSection: section)
    }
    
}
