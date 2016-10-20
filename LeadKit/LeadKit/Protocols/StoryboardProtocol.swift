//
//  StoryboardProtocol.swift
//  LeadKit
//
//  Created by Ivan Smolin on 20/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

/**
 *  protocol which helps us organize storyboards and view controllers creation
 */
public protocol StoryboardProtocol {

    associatedtype StoryboardIdentifier: RawRepresentable
    associatedtype ViewControllerIdentifier: RawRepresentable

    /**
     - returns: storyboard identifier with associatedtype type
     */
    static var storyboardIdentifier: StoryboardIdentifier { get }

    /**
     method which instantiate UIViewControlle instance for specific view controller identifier

     - parameter _: object which represents view controller identifier

     - returns: UIViewController instance
     */
    static func instantiateViewController(_: ViewControllerIdentifier) -> UIViewController
    
}
