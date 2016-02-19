//
//  TableViewCellsPool.swift
//  LeadKit
//
//  Created by Иван Смолин on 19/02/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// class that generates table view cells on initialization phase and then return its when necessary
public class TableViewCellsGenerator<T where T: UITableViewCell>: ObjectsGenerator<T> {
    /**
     initializer function
     
     - parameter poolSize:    number of cells to generate
     - parameter cellNibName: cell nib name
     
     - returns: nothing
     */
    init(poolSize: UInt, cellNibName: String) {
        super.init(poolSize: poolSize, objectsContructor: {() -> T in
            T.loadFromNib(named: cellNibName)
        })
    }
}
