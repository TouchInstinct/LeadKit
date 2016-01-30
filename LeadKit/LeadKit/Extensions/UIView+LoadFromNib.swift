//
//  UIView+LoadFromNib.swift
//  Knapsack
//
//  Created by Иван Смолин on 30/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension UINib {
    convenience public init(nibName name: String) {
        self.init(nibName: name, bundle: nil)
    }
}

extension UIView {
    public static func loadFromNib<T where T: NibNameProtocol, T: UIView>(forUserInterfaceIdiom interfaceIdiom: UIUserInterfaceIdiom) -> T {
        return loadFromNib(named: T.nibName(forConfiguration: interfaceIdiom))
    }
    
    public static func loadFromNib<T where T: StaticNibNameProtocol, T: UIView>() -> T {
        return loadFromNib(named: T.nibName())
    }
    
    public static func loadFromNib<T>(named nibName: String) -> T {
        return UINib(nibName: nibName).instantiateWithOwner(nil, options: nil).first as! T
    }
}