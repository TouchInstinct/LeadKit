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

private extension Double {
    static let halfPeriod = 0.5
}

public extension UIImageView {

    /// Rotates image view by 180 degrees via transform property with animation.
    var expandRotationBinder: Binder<Bool> {
        return Binder(self) { view, isExpanded in

            let angle = isExpanded ? CGFloat.pi / 2 : -CGFloat.pi / 2

            UIView.animateKeyframes(withDuration: CATransaction.animationDuration(), delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: .halfPeriod, animations: {
                    view.transform = view.transform.rotated(by: angle)
                })

                UIView.addKeyframe(withRelativeStartTime: .halfPeriod, relativeDuration: .halfPeriod, animations: {
                    view.transform = view.transform.rotated(by: angle)
                })
            })
        }
    }
}
