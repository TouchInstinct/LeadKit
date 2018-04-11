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

        let constraints = [
            centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            centerYAnchor.constraint(equalTo: parent.centerYAnchor),
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    /**
     Place and fix view to parent view's center with insets

     - parameter insets: desired view insets, by default is zero
     - parameter edges: edges to which no constraints are needed
     */
    func pinToSuperview(withInsets insets: UIEdgeInsets = .zero, excluding edges: UIRectEdge = []) {
        guard let superview = superview else {
            return
        }

        let topActive = !edges.contains(.top)
        let leadingActive = !edges.contains(.left)
        let bottomActive = !edges.contains(.bottom)
        let trailingActive = !edges.contains(.right)

        translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11, tvOS 11, *) {
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: insets.top)
                    .isActive = topActive
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: insets.left)
                    .isActive = leadingActive
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom)
                    .isActive = bottomActive
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right)
                    .isActive = trailingActive
        } else {
                topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = topActive
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = leadingActive
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = bottomActive
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = trailingActive
        }
    }

    private func scaleToFill() {
        guard let superview = superview else {
            return
        }

        let constraints: [NSLayoutConstraint]
        if #available(iOS 11, tvOS 11, *) {
            constraints = [
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
                leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor),
                rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor)
            ]
        } else {
            constraints = [
                topAnchor.constraint(equalTo: superview.topAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                leftAnchor.constraint(equalTo: superview.leftAnchor),
                rightAnchor.constraint(equalTo: superview.rightAnchor)
            ]
        }

        NSLayoutConstraint.activate(constraints)
    }

}
