//
//  Copyright (c) 2018 Touch Instinct
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

/// Type that performs some kind of type erasure for PaginationWrappable.
public final class AnyPaginationWrappable: PaginationWrappable {

    private typealias ViewSetter = (UIView?) -> Void

    public var footerView: UIView? {
        get {
            return footerViewBacking
        }
        set {
            footerViewSetter(newValue)
        }
    }

    public var backgroundView: UIView? {
        get {
            return backgroundViewBacking
        }
        set {
            backgroundViewSetter(newValue)
        }
    }

    public let scrollView: UIScrollView

    private let backgroundViewBacking: UIView?
    private let footerViewBacking: UIView?

    private let backgroundViewSetter: ViewSetter
    private let footerViewSetter: ViewSetter

    public init<View>(view: View) where View: PaginationWrappable {
        self.scrollView = view.scrollView
        self.backgroundViewBacking = view.backgroundView
        self.footerViewBacking = view.footerView

        var localView = view

        self.backgroundViewSetter = {
            localView.backgroundView = $0
        }

        self.footerViewSetter = {
            localView.footerView = $0
        }
    }

}
