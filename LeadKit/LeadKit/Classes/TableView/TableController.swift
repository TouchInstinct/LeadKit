//
//  TableViewController.swift
//  LeadKit
//
//  Created by Иван Смолин on 20/02/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

/// abstract class which holds few behaviour configuration properties,
/// inherit and add conformance for table view data source and delegate protocols
public class TableController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    /**
    enumeration which describes how to calculate and store view models for cells
    
    - Precalculated:        precacalculate view models for all cells and keep it in memory
    - OnTheFlight:          calculate view models when needed and forget it immideatelly
    - OnTheFlightWithCache: calculate view models when needed and cache it
    */
    internal enum TableControllerViewModelCalculationType {
        case Precalculated
        case OnTheFlight
        case OnTheFlightWithCache
    }
    
    /**
     enumeration which describes how to create cells
     
     - Preloaded:   load some amount of cells before data source delegate calls
     - OnTheFlight: let table view deside when to load cells
     */
    internal enum TableControllerCellCreationType {
        case Preloaded
        case OnTheFlight
    }
    
    internal let viewModelCalculationType: TableControllerViewModelCalculationType
    
    internal let cellCreationType: TableControllerCellCreationType
    
    internal init(viewModelCalculationType calculationType: TableControllerViewModelCalculationType = .OnTheFlight,
        cellCreationType creationType: TableControllerCellCreationType = .OnTheFlight) {
            self.viewModelCalculationType = calculationType
            self.cellCreationType = creationType
            
            super.init()
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        preconditionFailure("subclass should implement \(__FUNCTION__)")
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        preconditionFailure("subclass should implement \(__FUNCTION__)")
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        preconditionFailure("subclass should implement \(__FUNCTION__)")
    }
    
}
