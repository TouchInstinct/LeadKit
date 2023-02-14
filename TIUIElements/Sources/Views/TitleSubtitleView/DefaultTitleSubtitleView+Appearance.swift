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

extension DefaultTitleSubtitleView {
    public final class Layout: UIView.BaseWrappedLayout, WrappedViewLayout {

        public static var defaultLayout: Layout {
            Self()
        }

        public var spacing: CGFloat

        public init(insets: UIEdgeInsets = .zero,
                    centerOffset: UIOffset = .zero,
                    spacing: CGFloat = .zero) {

            self.spacing = spacing

            super.init(insets: insets, centerOffset: centerOffset)
        }
    }

    public final class Appearance: UIView.BaseAppearance<Layout>, WrappedViewAppearance {

        public static var defaultAppearance: Appearance {
            Self()
        }

        public var titleAppearance: UILabel.DefaultAppearance
        public var subtitleAppearance: UILabel.DefaultAppearance

        public init(layout: Layout = .defaultLayout,
                    backgroundColor: UIColor = .clear,
                    roundedCorners: CACornerMask = [],
                    cornerRadius: CGFloat = .zero,
                    shadow: UIViewShadow? = nil,
                    titleAppearance: UILabel.DefaultAppearance = .defaultAppearance,
                    subtitleAppearance: UILabel.DefaultAppearance = .defaultAppearance) {

            self.titleAppearance = titleAppearance
            self.subtitleAppearance = subtitleAppearance

            super.init(layout: layout,
                       backgroundColor: backgroundColor,
                       roundedCorners: roundedCorners,
                       cornerRadius: cornerRadius,
                       shadow: shadow)
        }
    }
}
