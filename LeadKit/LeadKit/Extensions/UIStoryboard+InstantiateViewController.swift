//
//  UIStoryboard+InstantiateViewController.swift
//  Knapsack
//
//  Created by Иван Смолин on 24/01/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

extension UIStoryboard {
    /**
     method for instanciating new UIViewController subclass from storyboard using storyboard identifier provided by StoryboardIdentifierProtocol protocol implementation
     
     - returns: UIViewController subclass instance
     */
    public func instantiateViewController<T where T: UIViewController, T: StoryboardIdentifierProtocol>() -> T {
        return instantiateViewControllerWithIdentifier(T.storyboardIdentifier()) as! T
    }
}