//
//  CellsControllerProtocol.swift
//  LeadKit
//
//  Created by Ivan Smolin on 08/06/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 *  protocol which ensures that specific type can configure cell and return cell attributes for specific index path
 */
public protocol CellsControllerProtocol {
    associatedtype CellType

    /**
     method which returns cell identifier for given index path

     - parameter indexPath: NSIndexPath object

     - returns: cell identifier for specified index path
     */
    func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String

    /**
     method which configures given cell for given index path

     - parameter cell:        cell to configure
     - parameter atIndexPath: index path of given cell

     - returns: nothing
     */
    func configureCell(cell: CellType, atIndexPath: NSIndexPath)

    /**
     method which returns height of cell for given index path

     - parameter indexPath: NSIndexPath object

     - returns: height of cell for specified index path
     */
    func heightForCellAtIndexPath(indexPath: NSIndexPath) -> CGFloat
    
}
