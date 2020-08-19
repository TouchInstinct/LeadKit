//
//  Copyright (c) 2020 Touch Instinct
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
import TIUIKitCore

/// Type that performs some kind of type erasure for ActivityIndicator.
public struct AnyActivityIndicator: Animatable {

    private let backgroundView: UIView
    private let animatableView: Animatable

    /// Initializer with indicator that should be wrapped.
    ///
    /// - Parameter _: indicator for wrapping.
    public init<Indicator>(_ base: Indicator) where Indicator: ActivityIndicator {
        animatableView = base.view
        backgroundView = base.view
    }

    /// Initializer with placeholder view, that wraps indicator.
    ///
    /// - Parameter loadingIndicatorHolder: placeholder view, containing indicator.
    public init(activityIndicatorHolder: ActivityIndicatorHolder) {
        animatableView = activityIndicatorHolder.activityIndicator
        backgroundView = activityIndicatorHolder.indicatorOwner
    }

    /// The background view.
    var view: UIView {
        return backgroundView
    }

    public func startAnimating() {
        animatableView.startAnimating()
    }

    public func stopAnimating() {
        animatableView.stopAnimating()
    }
}
