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

import Foundation

/**
 *  protocol which ensures that specific type can return nib name of view for specific configuration
 */
public protocol AbstractNibNameProtocol {
    associatedtype ConfigurationType

    /**
     static method which returns nib name for specific configuration
     
     - parameter configuration: object which represents configuration
     
     - returns: nib name string
     */
    static func nibName(forConfiguration configuration: ConfigurationType) -> String
}

/**
 *  protocol which ensures that specific type can return nib name of view
 for specified UserInterfaceIdiom (iPhone, iPad, AppleTV)
 */

public protocol NibNameProtocol: AbstractNibNameProtocol {
    /**
     static method which returns nib name for specific UIUserInterfaceIdiom value
     
     - parameter configuration: object which represents configuration in terms of user interface idiom
     
     - returns: nib name string
     */
    static func nibName(forConfiguration configuration: UIUserInterfaceIdiom) -> String
}
