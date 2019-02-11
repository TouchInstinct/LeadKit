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

    /// Crop image to square from center.
    ///
    /// - Returns: A new cropped image or nil if something goes wrong.
    func cropFromCenterToSquare() -> CGImage? {
        let shortest = min(width, height)

        let widthCropSize = width > shortest ? (width - shortest) : 0
        let heightCropSize = height > shortest ? (height - shortest) : 0

        let left = widthCropSize / 2
        let top = heightCropSize / 2

        let cropRect = CGRect(x: left,
                              y: top,
                              width: width - widthCropSize,
                              height: height - heightCropSize)

        return cropping(to: cropRect)
    }

    /// Crop image with given margin values.
    ///
    /// - Parameters:
    ///   - top: Top margin.
    ///   - left: Left margin.
    ///   - bottom: Bottom margin.
    ///   - right: Right margin.
    /// - Returns: A new CGImage cropped with given paddings or nil if something goes wrong.
    func crop(top: CGFloat = 0,
              left: CGFloat = 0,
              bottom: CGFloat = 0,
              right: CGFloat = 0) -> CGImage? {

        let rect = CGRect(x: left,
                          y: top,
                          width: CGFloat(width) - left - right,
                          height: CGFloat(height) - top - bottom)

        return cropping(to: rect)
    }
}
