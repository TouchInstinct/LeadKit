//
//  StoryboardProtocol+Extensions.swift
//  LeadKit
//
//  Created by Ivan Smolin on 20/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension StoryboardProtocol where StoryboardIdentifier.RawValue == String, ViewControllerIdentifier.RawValue == String {

    /**
     - returns: UIStoryboradInstance with StoryboardIdentifier name
     */
    public static var uiStoryboard: UIStoryboard {
        return UIStoryboard(name: storyboardIdentifier.rawValue, bundle: Bundle.main)
    }

    /**
     method for instantiating UIViewController from storyboard using view controller identifier

     - parameter _: object which represents view controller identifier

     - returns: UIViewController instance
     */
    public static func instantiateViewController(_ viewController: ViewControllerIdentifier) -> UIViewController {
        return uiStoryboard.instantiateViewController(withIdentifier: viewController.rawValue)
    }
    
}
