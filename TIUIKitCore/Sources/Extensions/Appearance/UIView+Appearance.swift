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

    // MARK: - Layout Variations

    public struct NoLayout: ViewLayout {
        public static var defaultLayout: Self {
            Self()
        }
    }

    open class BaseSizeLayout {
        public var size: CGSize

        public init(size: CGSize = .infinity) {
            self.size = size
        }
    }

    public final class DefaultLayout: BaseSizeLayout, SizeViewLayout {
        public static var defaultLayout: Self {
            Self()
        }
    }

    // MARK: - WrappedView Layout

    open class BaseWrappedLayout: BaseSizeLayout {
        public var centerOffset: UIOffset
        public var insets: UIEdgeInsets

        public init(insets: UIEdgeInsets = .zero,
                    size: CGSize = .infinity,
                    centerOffset: UIOffset = .nan) {

            self.centerOffset = centerOffset
            self.insets = insets

            super.init(size: size)
        }
    }

    public final class DefaultWrappedLayout: BaseWrappedLayout, WrappedViewLayout {
        public static var defaultLayout: Self {
            Self()
        }
    }

    // MARK: - Appearance Variations

    open class BaseAppearance<Layout: ViewLayout> {
        public var layout: Layout

        public var backgroundColor: UIColor
        public var roundedCorners: CACornerMask
        public var cornerRadius: CGFloat
        public var shadow: UIViewShadow?

        public init(layout: Layout = .defaultLayout,
                    backgroundColor: UIColor = .clear,
                    roundedCorners: CACornerMask = [],
                    cornerRadius: CGFloat = .zero,
                    shadow: UIViewShadow? = nil) {

            self.layout = layout
            self.backgroundColor = backgroundColor
            self.roundedCorners = roundedCorners
            self.cornerRadius = cornerRadius
            self.shadow = shadow
        }
    }

    public final class DefaultAppearance: BaseAppearance<DefaultLayout>, ViewAppearance {
        public static var defaultAppearance: Self {
            Self()
        }
    }

    // MARK: - WrappedView Appearance

    open class BaseWrappedViewHolderAppearance<SubviewAppearance: WrappedViewAppearance,
                                               Layout: ViewLayout>: BaseAppearance<Layout> {

        public var subviewAppearance: SubviewAppearance

        public init(layout: Layout = .defaultLayout,
                    backgroundColor: UIColor = .clear,
                    roundedCorners: CACornerMask = [],
                    cornerRadius: CGFloat = .zero,
                    shadow: UIViewShadow? = nil,
                    subviewAppearance: SubviewAppearance = .defaultAppearance) {

            self.subviewAppearance = subviewAppearance

            super.init(layout: layout,
                       backgroundColor: backgroundColor,
                       roundedCorners: roundedCorners,
                       cornerRadius: cornerRadius,
                       shadow: shadow)
        }
    }

    public final class DefaultWrappedViewHolderAppearance<SubviewAppearance: WrappedViewAppearance,
                                                          Layout: ViewLayout>: BaseWrappedViewHolderAppearance<SubviewAppearance, Layout>,
                                                                               WrappedViewHolderAppearance {
        public static var defaultAppearance: Self {
            Self()
        }
    }

    public final class DefaultWrappedAppearance: BaseAppearance<DefaultWrappedLayout>, WrappedViewAppearance {
        public static var defaultAppearance: Self {
            Self()
        }
    }
}

extension UIView.DefaultWrappedViewHolderAppearance: WrappedViewAppearance where Layout: WrappedViewLayout {

}
