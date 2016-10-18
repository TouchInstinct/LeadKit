//
//  UICollectionView+CellRegistration.swift
//  LeadKit
//
//  Created by Fedor on 18.10.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UICollectionView {
    /**
     method which register UICollectionViewCell subclass for reusing in UICollectionView with reuse identifier
     provided by ReuseIdentifierProtocol protocol implementation and nib name
     provided by StaticNibNameProtocol protocol implementation
     
     - parameter cellClass: UICollectionViewCell subclass which implements ReuseIdentifierProtocol and StaticNibNameProtocol
     
     - see: ReuseIdentifierProtocol, StaticNibNameProtocol
     */

    public func registerNib<T>(forCellClass cellClass: T.Type)
        where T: ReuseIdentifierProtocol, T: UICollectionViewCell, T: StaticNibNameProtocol {

            register(UINib(nibName: T.nibName), forCellReuseIdentifier: T.reuseIdentifier)
    }

    /**
     method which register UICollectionViewCell subclass for reusing in UICollectionView with reuse identifier
     provided by ReuseIdentifierProtocol protocol implementation and nib name
     provided by NibNameProtocol protocol implementation
     
     - parameter cellClass:      UICollectionViewCell subclass which implements ReuseIdentifierProtocol and NibNameProtocol
     - parameter interfaceIdiom: UIUserInterfaceIdiom value for NibNameProtocol
     
     - see: ReuseIdentifierProtocol, NibNameProtocol
     */

    public func registerNib<T>(forCellClass cellClass: T.Type,
                            forUserInterfaceIdiom interfaceIdiom: UIUserInterfaceIdiom)
        where T: ReuseIdentifierProtocol, T: UICollectionViewCell, T: NibNameProtocol {
            
            let nib = UINib(nibName: T.nibName(forConfiguration: interfaceIdiom))
            register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

}
