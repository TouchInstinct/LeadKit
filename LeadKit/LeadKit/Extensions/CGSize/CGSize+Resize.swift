//
//  Copyright (c) 2017 Touch Instinct
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

import CoreGraphics.CGGeometry

public extension CGSize {

    /// Calculates rect "inside" CGSize to match requested size with accordance to resize mode.
    ///
    /// - Parameters:
    ///   - newSize: Requested new size.
    ///   - resizeMode: Resize mode to use.
    /// - Returns: A new CGRect instance matching request parameters.
    public func resizeRect(forNewSize newSize: CGSize, resizeMode: ResizeMode) -> CGRect {
        let horizontalRatio = newSize.width / CGFloat(width)
        let verticalRatio = newSize.height / CGFloat(height)

        let ratio: CGFloat

        switch resizeMode {
        case .scaleToFill:
            ratio = 1
        case .scaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        case .scaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
        }

        let newWidth = resizeMode == .scaleToFill ? newSize.width : CGFloat(width) * ratio
        let newHeight = resizeMode == .scaleToFill ? newSize.height : CGFloat(height) * ratio

        let originX: CGFloat
        let originY: CGFloat

        if newWidth > newSize.width {
            originX = (newSize.width - newWidth) / 2
        } else if newWidth < newSize.width {
            originX = newSize.width / 2 - newWidth / 2
        } else {
            originX = 0
        }

        if newHeight > newSize.height {
            originY = (newSize.height - newHeight) / 2
        } else if newHeight < newSize.height {
            originY = newSize.height / 2 - newHeight / 2
        } else {
            originY = 0
        }

        return CGRect(origin: CGPoint(x: originX, y: originY),
                      size: CGSize(width: newWidth, height: newHeight))
    }

}
