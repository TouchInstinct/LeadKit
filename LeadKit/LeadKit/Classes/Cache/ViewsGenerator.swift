//
//  TableViewCellsPool.swift
//  LeadKit
//
//  Created by Иван Смолин on 19/02/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// class that generates views on initialization phase and then return its when necessary
public class ViewsGenerator<T where T: UIView>: ObjectsGenerator<T> {
    /**
     initializer function
     
     - parameter poolSize: number of cells to generate
     - parameter nibName: view nib name     
     */
    init(poolSize: UInt, nibName: String) {
        super.init(poolSize: poolSize, objectsContructor: { T.loadFromNib(named: nibName) })
    }
    
}
