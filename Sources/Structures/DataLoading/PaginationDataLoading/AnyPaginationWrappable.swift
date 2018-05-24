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
    private typealias ViewGetter = () -> UIView?

    public var footerView: UIView? {
        get {
            return footerViewGetter()
        }
        set {
            footerViewSetter(newValue)
        }
    }

    public var backgroundView: UIView? {
        get {
            return backgroundViewGetter()
        }
        set {
            backgroundViewSetter(newValue)
        }
    }

    public let scrollView: UIScrollView

    private let backgroundViewSetter: ViewSetter
    private let footerViewSetter: ViewSetter

    private let backgroundViewGetter: ViewGetter
    private let footerViewGetter: ViewGetter

    public init<View: PaginationWrappable>(view: View) {
        self.scrollView = view.scrollView

        var localView = view

        self.backgroundViewSetter = {
            localView.backgroundView = $0
        }
        self.backgroundViewGetter = {
            localView.backgroundView
        }

        self.footerViewSetter = {
            localView.footerView = $0
        }
        self.footerViewGetter = {
            localView.footerView
        }
    }

}
