//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import CoreGraphics

public extension CGImage {

    /**
     method which creates new CGImage instance filled by given color

     - parameter color:  color to fill
     - parameter width:  width of new image
     - parameter height: height of new image
     - parameter opaque: a flag indicating whether the bitmap is opaque (default: False)

     - returns: new instanse of UIImage with given size and color
     */
    public static func create(color: CGColor,
                              width: Int,
                              height: Int,
                              opaque: Bool = false) -> CGImage? {

        let context = CGContext.create(width: width,
                                       height: height,
                                       bitmapInfo: opaque ? opaqueBitmapInfo : alphaBitmapInfo)

        guard let ctx = context else {
            return nil
        }

        ctx.setFillColor(color)
        ctx.fill(CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height)))

        return ctx.makeImage()
    }

    /**
     creates an image from a UIView.

     - parameter fromView: The source view.

     - returns A new image
     */
    public static func create(fromView view: UIView) -> CGImage? {
        let size = view.bounds.size

        let ctxWidth = Int(ceil(size.width))
        let ctxHeight = Int(ceil(size.height))

        guard let ctx = CGContext.create(width: ctxWidth, height: ctxHeight) else {
            return nil
        }

        ctx.translateBy(x: 0, y: size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)

        view.layer.render(in: ctx)

        return ctx.makeImage()
    }

}
