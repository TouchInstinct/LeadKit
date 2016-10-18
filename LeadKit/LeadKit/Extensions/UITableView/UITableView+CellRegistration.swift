//
//  UITableView+CellRegistration.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UITableView {
    /**
     method which register UITableViewCell subclass for reusing in UITableView with reuse identifier
     provided by ReuseIdentifierProtocol protocol implementation and nib name
     provided by StaticNibNameProtocol protocol implementation
     
     - parameter cellClass: UITableViewCell subclass which implements ReuseIdentifierProtocol and StaticNibNameProtocol
     
     - see: ReuseIdentifierProtocol, StaticNibNameProtocol
     */
    
    public func registerNib<T>(forCellClass cellClass: T.Type)
        where T: ReuseIdentifierProtocol, T: UITableViewCell, T: StaticNibNameProtocol {

        register(UINib(nibName: T.nibName), forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /**
     method which register UITableViewCell subclass for reusing in UITableView with reuse identifier
     provided by ReuseIdentifierProtocol protocol implementation and nib name
     provided by NibNameProtocol protocol implementation
     
     - parameter cellClass:      UITableViewCell subclass which implements ReuseIdentifierProtocol and NibNameProtocol
     - parameter interfaceIdiom: UIUserInterfaceIdiom value for NibNameProtocol
     
     - see: ReuseIdentifierProtocol, NibNameProtocol
     */
    
    public func registerNib<T>(forCellClass cellClass: T.Type,
                            forUserInterfaceIdiom interfaceIdiom: UIUserInterfaceIdiom)
        where T: ReuseIdentifierProtocol, T: UITableViewCell, T: NibNameProtocol {

        let nib = UINib(nibName: T.nibName(forConfiguration: interfaceIdiom))
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
}
