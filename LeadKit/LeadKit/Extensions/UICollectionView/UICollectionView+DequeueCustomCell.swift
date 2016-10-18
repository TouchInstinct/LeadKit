//
//  UICollectionView+DequeueCustomCell.swift
//  LeadKit
//
//  Created by Fedor on 18.10.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UICollectionView {
    /**
     method for dequeueing reusable table view cell with specific class using reuse identifier
     provided by ReuseIdentifierProtocol implementation

     - parameter indexPath: NSIndexPath object

     - returns: UICollectionViewCell subclass instance

     - see: ReuseIdentifierProtocol
     */

    public func dequeueReusableCell<T>(forIndexPath indexPath: IndexPath) -> T
        where T: UICollectionViewCell, T: ReuseIdentifierProtocol {

            return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

}
