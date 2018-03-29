//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public extension UIView {

    /**
     Place and fix view to parent view's center

     - parameter size: desired view size, by default size is equal parent's size
     */
    func setToCenter(withSize size: CGSize? = nil) {
        guard let parent = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false

        guard let size = size else {
            scaleToFill()
            return
        }

        centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive   = true
        widthAnchor.constraint(equalToConstant: size.width).isActive     = true
    }

    /**
     Place and fix view to parent view's center with insets

     - parameter insets: desired view insets, by default is zero
     */
    func setToCenter(wtihInsets insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11, *) {
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor,
                                 constant: insets.top).isActive = true
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor,
                                     constant: insets.left).isActive = true
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                                    constant: -insets.bottom).isActive = true
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                                      constant: -insets.right).isActive = true
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        }
    }

    private func scaleToFill() {
        guard let superview = superview else {
            return
        }

        if #available(iOS 11, *) {
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive       = true
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor).isActive     = true
            rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor).isActive   = true
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor).isActive       = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive     = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive   = true
        }
    }

}
