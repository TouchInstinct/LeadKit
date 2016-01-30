//
//  UITableViewCell+DequeueFromTableView.swift
//  Knapsack
//
//  Created by Иван Смолин on 24/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension UITableView {
    public func dequeueReusableCell<T where T: UITableViewCell, T: ReuseIdentifierProtocol>(forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithIdentifier(T.reuseIdentifier(), forIndexPath: indexPath) as! T
    }
}