//
//  UITableView+CellRegistration.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension UITableView {
    public func registerNib<T where T: ReuseIdentifierProtocol, T: UITableViewCell, T: StaticNibNameProtocol>(forCellClass cellClass: T.Type) {
        self.registerNib(UINib(nibName: T.nibName()), forCellReuseIdentifier: T.reuseIdentifier())
    }
    
    public func registerNib<T where T: ReuseIdentifierProtocol, T: UITableViewCell, T: NibNameProtocol>(forCellClass cellClass: T.Type, forUserInterfaceIdiom interfaceIdiom: UIUserInterfaceIdiom) {
        self.registerNib(UINib(nibName: T.nibName(forConfiguration: interfaceIdiom)), forCellReuseIdentifier: T.reuseIdentifier())
    }
}