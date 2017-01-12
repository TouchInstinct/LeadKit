//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
