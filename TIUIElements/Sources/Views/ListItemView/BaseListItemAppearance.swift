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

import TIUIKitCore
import UIKit

open class BaseListItemAppearance<LeadingViewAppearance: WrappedViewAppearance,
                                  MiddleViewAppearance: WrappedViewAppearance,
                                  TrailingViewAppearance: WrappedViewAppearance>: UIView.BaseAppearance<UIView.DefaultWrappedLayout> {

    public var leadingViewAppearance: LeadingViewAppearance
    public var middleViewAppearance: MiddleViewAppearance
    public var trailingAppearance: TrailingViewAppearance

    public init(layout: UIView.DefaultWrappedLayout = .defaultLayout,
                backgroundColor: UIColor = .clear,
                roundedCorners: CACornerMask = [],
                cornerRadius: CGFloat = .zero,
                shadow: UIViewShadow? = nil,
                leadingViewAppearance: LeadingViewAppearance = .defaultAppearance,
                middleViewAppearance: MiddleViewAppearance = .defaultAppearance,
                trailingViewAppearance: TrailingViewAppearance = .defaultAppearance) {

        self.leadingViewAppearance = leadingViewAppearance
        self.middleViewAppearance = middleViewAppearance
        self.trailingAppearance = trailingViewAppearance

        super.init(layout: layout,
                   backgroundColor: backgroundColor,
                   roundedCorners: roundedCorners,
                   cornerRadius: cornerRadius,
                   shadow: shadow)
    }
}
