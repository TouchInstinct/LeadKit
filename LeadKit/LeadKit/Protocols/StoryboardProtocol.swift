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

    associatedtype StoryboardIdentifier
    associatedtype ViewControllerIdentifier

    /**
     - returns: storyboard identifier with associatedtype type
     */
    static var storyboardIdentifier: StoryboardIdentifier { get }

    /**
     - returns: bundle for storyboard initialization
     */
    static var bundle: Bundle? { get }

    /**
     method which instantiate UIViewControlle instance for specific view controller identifier

     - parameter _: object which represents view controller identifier

     - returns: UIViewController instance
     */
    static func instantiateViewController(_: ViewControllerIdentifier) -> UIViewController
    
}
