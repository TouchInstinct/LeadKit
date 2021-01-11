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

public extension CGBitmapInfo {

    // The bitmapInfo value are hard-coded to prevent an "unsupported parameter combination" error

    static let alphaBitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
    static let opaqueBitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.none.rawValue)
}

public extension CGContext {

    /// Creates a bitmap graphics context with parameters taken from a given image.
    ///
    /// - Parameters:
    ///   - cgImage: CGImage instance from which the parameters will be taken.
    ///   - fallbackColorSpace: Fallback color space if image doesn't have it.
    /// - Returns: A new bitmap context, or NULL if a context could not be created.
    static func create(forCGImage cgImage: CGImage,
                       fallbackColorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()) -> CGContext? {

        create(width: cgImage.width,
               height: cgImage.height,
               bitmapInfo: cgImage.bitmapInfo,
               colorSpace: cgImage.colorSpace ?? fallbackColorSpace,
               bitsPerComponent: cgImage.bitsPerComponent)
    }

    /// Creates a bitmap graphics context.
    ///
    /// - Parameters:
    ///   - width: The width, in pixels, of the required bitmap.
    ///   - height: The height, in pixels, of the required bitmap.
    ///   - bitmapInfo: Constants that specify whether the bitmap should contain an alpha channel,
    /// the alpha channel’s relative location in a pixel,
    /// and information about whether the pixel components are floating-point or integer values.
    ///   - colorSpace: The color space to use for the bitmap context.
    ///   - bitsPerComponent: The number of bits to use for each component of a pixel in memory.
    /// - Returns: A new bitmap context, or NULL if a context could not be created.
    static func create(width: Int,
                       height: Int,
                       bitmapInfo: CGBitmapInfo = .alphaBitmapInfo,
                       colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB(),
                       bitsPerComponent: Int = 8) -> CGContext? {

        CGContext(data: nil,
                  width: width,
                  height: height,
                  bitsPerComponent: bitsPerComponent,
                  bytesPerRow: 0,
                  space: colorSpace,
                  bitmapInfo: bitmapInfo.rawValue)
    }
}
