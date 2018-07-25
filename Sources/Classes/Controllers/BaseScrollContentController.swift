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

import RxSwift
import RxCocoa

public typealias ScrollViewHolderView = UIView & ScrollViewHolder

/// Base controller configurable with view model and ScrollViewHolder custom view.
open class BaseScrollContentController<ViewModel, View: ScrollViewHolderView>: BaseCustomViewController<ViewModel, View> {

    private let defaultInsetsRelay = BehaviorRelay<UIEdgeInsets>(value: .zero)

    private var bottomInsetDisposable: Disposable?

    /// Bind given driver to bottom inset of scroll view. Takes into account default bottom insets.
    ///
    /// - Parameter bottomInsetDriver: Driver that emits CGFloat bottom inset changes.
    public func bindBottomInsetBinding(from bottomInsetDriver: Driver<CGFloat>) {
        bottomInsetDisposable = bottomInsetDriver
            .withLatestFrom(defaultInsetsRelay.asDriver()) {
                $0 + $1.bottom
            }
            .drive(customView.scrollView.rx.bottomInsetBinder)
    }

    /// Unbind scroll view from previous binding.
    public func unbindBottomInsetBinding() {
        bottomInsetDisposable?.dispose()
    }

    /// Default insets used for contained scroll view.
    public var defaultInsets: UIEdgeInsets {
        get {
            return defaultInsetsRelay.value
        }
        set {
            defaultInsetsRelay.accept(newValue)
            customView.scrollView.contentInset = newValue
            customView.scrollView.scrollIndicatorInsets = newValue
        }
    }

    /// Contained UIScrollView instance.
    public var scrollView: UIScrollView {
        return customView.scrollView
    }

}

public extension BaseScrollContentController {

    /// On iOS, tvOS 11+ sets contentInsetAdjustmentBehavior to .never.
    /// On earlier versions sets automaticallyAdjustsScrollViewInsets to false.
    func disableAdjustsScrollViewInsets() {
        if #available(iOS 11.0, tvOS 11.0, *) {
            customView.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }

}
