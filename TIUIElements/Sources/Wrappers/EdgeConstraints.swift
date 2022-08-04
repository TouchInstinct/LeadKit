//
//  Copyright (c) 2022 Touch Instinct
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

public struct EdgeConstraints {
    public let leadingConstraint: NSLayoutConstraint
    public let trailingConstraint: NSLayoutConstraint
    public let topConstraint: NSLayoutConstraint
    public let bottomConstraint: NSLayoutConstraint

    public init(leadingConstraint: NSLayoutConstraint,
                trailingConstraint: NSLayoutConstraint,
                topConstraint: NSLayoutConstraint,
                bottomConstraint: NSLayoutConstraint) {
        
        self.leadingConstraint = leadingConstraint
        self.trailingConstraint = trailingConstraint
        self.topConstraint = topConstraint
        self.bottomConstraint = bottomConstraint
    }

    public var allConstraints: [NSLayoutConstraint] {
        [
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            bottomConstraint
        ]
    }

    public func activate() {
        NSLayoutConstraint.activate(allConstraints)
    }

    public func deactivate() {
        NSLayoutConstraint.deactivate(allConstraints)
    }

    public func update(from insets: UIEdgeInsets) {
        leadingConstraint.constant = insets.left
        trailingConstraint.constant = -insets.right
        topConstraint.constant = insets.top
        bottomConstraint.constant = -insets.bottom
    }
}
