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

open class DashedBoundsLayer: CAShapeLayer {

    public static var predefinedColors: [UIColor] {
        [.red, .green, .blue, .brown, .gray, .yellow, .magenta, .black, .orange, .purple, .cyan]
    }

    private var viewBoundsObservation: NSKeyValueObservation?

    public var dashColor: UIColor = predefinedColors.randomElement() ?? .black

    // MARK: - Open methods

    open func configure(on view: UIView) {
        fillColor = UIColor.clear.cgColor
        strokeColor = dashColor.cgColor
        lineWidth = 1
        lineDashPattern = [4.0, 2.0]

        updateGeometry(from: view)

        view.layer.addSublayer(self)

        viewBoundsObservation = view.observe(\.bounds, options: [.new]) { [weak self] view, _ in
            self?.updateGeometry(from: view)
        }
    }

    open func updateGeometry(from view: UIView) {
        frame = view.bounds
        path = UIBezierPath(rect: view.bounds).cgPath
    }
}

// MARK: - UIView + DashedBoundsLayer

public extension UIView {

    @discardableResult
    func debugBoundsVisually(debugSubviews: Bool = true) -> UIView {
        disableBoundsVisuallyDebug()

        if debugSubviews {
            for subview in subviews {
                subview.debugBoundsVisually(debugSubviews: debugSubviews)
            }
        }

        let dashedLayer = DashedBoundsLayer()
        dashedLayer.configure(on: self)

        return self
    }

    func disableBoundsVisuallyDebug() {
        for sublayer in layer.sublayers ?? [] {
            if sublayer is DashedBoundsLayer {
                sublayer.removeFromSuperlayer()
            }
        }

        for subview in subviews {
            subview.disableBoundsVisuallyDebug()
        }
    }
}
