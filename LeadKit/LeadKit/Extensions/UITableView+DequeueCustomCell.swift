//
//  UITableViewCell+DequeueFromTableView.swift
//  Knapsack
//
//  Created by Иван Смолин on 24/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension UITableView {
    /**
     method for dequeueing reusable table view cell with specific class using reuse identifier provided by ReuseIdentifierProtocol implementation
     
     - parameter indexPath: NSIndexPath object
     
     - returns: UITableViewCell subclass instance
     
     - see: ReuseIdentifierProtocol
     */
    public func dequeueReusableCell<T where T: UITableViewCell, T: ReuseIdentifierProtocol>(forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithIdentifier(T.reuseIdentifier(), forIndexPath: indexPath) as! T
    }
}