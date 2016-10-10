//
//  IndexPath+ImmutableIndexPath.swift
//  LeadKit
//
//  Created by Иван Смолин on 21/03/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

// http://stackoverflow.com/a/21686163

extension IndexPath {
        /// return immutable copy if class is not NSIndexPath or return self
    var immutableIndexPath: IndexPath {
        if Mirror(reflecting: self).subjectType == IndexPath.self {  // check for UIMutableIndexPath
            return self
        }
        
        return IndexPath(item: item, section: section)
    }
    
}
