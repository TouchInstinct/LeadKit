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

public extension UINib {
    convenience public init(nibName name: String) {
        self.init(nibName: name, bundle: nil)
    }
}

public extension UIView {
    /**
     method which return UIView subclass instance loaded from nib using nib name provided by NibNameProtocol implementation
     
     - parameter interfaceIdiom: UIUserInterfaceIdiom value for passing into NibNameProtocol
     
     - returns: UIView subclass instance
     */

    public static func loadFromNib<T>
        (forUserInterfaceIdiom interfaceIdiom: UIUserInterfaceIdiom) -> T where T: NibNameProtocol, T: UIView {
        return loadFromNib(named: T.nibName(forConfiguration: interfaceIdiom))
    }

    /**
     method which return UIView subclass instance loaded from nib using nib name
     provided by StaticNibNameProtocol implementation
     
     - returns: UIView subclass instance
     */
    public static func loadFromNib<T>() -> T where T: StaticNibNameProtocol, T: UIView {
        return loadFromNib(named: T.nibName)
    }

    /**
     method which loads UIView (or subclass) instance from nib using given nib name parameter
     
     - parameter nibName: nib name
     
     - returns: UIView subclass instance
     */
    public static func loadFromNib<T>(named nibName: String) -> T {
        guard let nibView = UINib(nibName: nibName).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("Can't nstantiate nib view with type \(T.self)")
        }

        return nibView

    }

}
