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

public struct DefaultRangeFilterAppearance {

    public var intervalInputAppearance: DefaultIntervalInputAppearance
    public var stepSliderAppearance: DefaultStepSliderAppearance

    public var spacing: CGFloat
    public var leadingSpacing: CGFloat
    public var trailingSpacing: CGFloat
    public var fontColor: UIColor

    public init(intervalInputAppearance: DefaultIntervalInputAppearance = .init(),
                stepSliderAppearance: DefaultStepSliderAppearance = .init(),
                spacing: CGFloat = 16,
                leadingSpacing: CGFloat = 16,
                trailingSpacing: CGFloat = 16,
                fontColor: UIColor = .black) {

        self.intervalInputAppearance = intervalInputAppearance
        self.stepSliderAppearance = stepSliderAppearance
        self.spacing = spacing
        self.leadingSpacing = leadingSpacing
        self.trailingSpacing = trailingSpacing
        self.fontColor = fontColor
    }
}
