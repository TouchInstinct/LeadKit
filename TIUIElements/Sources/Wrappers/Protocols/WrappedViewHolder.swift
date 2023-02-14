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

public protocol WrappedViewHolder {
    associatedtype View: UIView

    var wrappedView: View { get }
    var contentView: UIView { get }
    var contentInsets: UIEdgeInsets { get set }
}

public extension WrappedViewHolder {
    func wrappedViewConstraints() -> EdgeConstraints {
        .init(leadingConstraint: wrappedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              trailingConstraint: wrappedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              topConstraint: wrappedView.topAnchor.constraint(equalTo: contentView.topAnchor),
              bottomConstraint: wrappedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
    }

    func configureWrappedViewLayout() -> EdgeConstraints {
        wrappedView.translatesAutoresizingMaskIntoConstraints = false

        let contentEdgeConstraints = wrappedViewConstraints()
        contentEdgeConstraints.activate()

        return contentEdgeConstraints
    }
}

public extension WrappedViewHolder where Self: UIView {
    var contentView: UIView {
        self
    }
}
