//
//  Copyright (c) 2023 Touch Instinct
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

extension UIView {
    public var skeletonableViews: [UIView] {
        if let skeletonableView = self as? Skeletonable {
            return  skeletonableView.viewsToSkeletone
        }

        return subviews
    }

    var isSkeletonsContainer: Bool {
        if let skeletonableView = self as? Skeletonable {
            return !skeletonableView.viewsToSkeletone.isEmpty
        }

        return  !subviews.isEmpty
    }

    var viewType: SkeletonLayer.ViewType {
        if let labelView = self as? UILabel {
            return .label(labelView)

        } else if let textView = self as? UITextView {
            return .textView(textView)

        } else if let imageView = self as? UIImageView {
            return .imageView(imageView)

        } else if self.isSkeletonsContainer {
            return .container(self)

        } else {
            return .generic(self)
        }
    }
}

extension UITextView {
    var isMultiline: Bool {
        guard let text = text, let font = font else {
            return false
        }

        let labelTextSize = (text as NSString).size(withAttributes: [.font: font])

        return labelTextSize.width > bounds.width
    }
}

extension UILabel {
    var isMultiline: Bool {
        // Unwrapping font to mute worning while casting UIFont! to Any
        guard let text = text, let font = font else {
            return false
        }

        let labelTextSize = (text as NSString).size(withAttributes: [.font: font])

        return labelTextSize.width > bounds.width
    }
}
