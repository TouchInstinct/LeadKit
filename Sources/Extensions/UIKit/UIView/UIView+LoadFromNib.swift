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

public extension UIView {

    /// Method which loads UIView (or subclass) instance from nib using
    /// nib name provided by StaticNibNameProtocol implementation
    ///
    /// - Parameter bundle: The bundle in which to search for the nib file.
    ///                     If you specify nil, this method looks for the nib file in the main bundle.
    /// - Returns: UIView or UIView subclass instance
    static func loadFromNib<T>(bundle: Bundle? = nil) -> T where T: UIView {
        loadFromNib(named: T.xibName, bundle: bundle)
    }

    /// Method which loads UIView (or subclass) instance from nib using given nib name parameter
    ///
    /// - Parameters:
    ///   - nibName: nib name
    ///   - bundle:  The bundle in which to search for the nib file.
    ///              If you specify nil, this method looks for the nib file in the main bundle.
    ///   - owner:   current owner
    /// - Returns: UIView or UIView subclass instance
    static func loadFromNib<T>(named nibName: String, bundle: Bundle? = nil, owner: UIView? = nil) -> T {
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let nibView = nib.instantiate(withOwner: owner, options: nil).first as? T else {
            fatalError("Can't instantiate nib view with type \(T.self)")
        }

        return nibView
    }
}
