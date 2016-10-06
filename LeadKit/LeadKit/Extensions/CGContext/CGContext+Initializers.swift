//
//  CGContext+Initializers.swift
//  LeadKit
//
//  Created by Ivan Smolin on 04/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import CoreGraphics

public extension CGContext {

    /**
     method which creates an instance of CGContext with parameters taken from a given image

     - parameter forCGImage: CGImage instance from which the parameters will be taken
     - parameter fallbackColorSpace: fallback color space if image doesn't have it
     */
    public static func create(forCGImage cgImage: CGImage,
                              fallbackColorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()) -> CGContext? {

        return create(width: cgImage.width,
                      height: cgImage.height,
                      bitmapInfo: cgImage.bitmapInfo,
                      colorSpace: cgImage.colorSpace ?? fallbackColorSpace,
                      bitsPerComponent: cgImage.bitsPerComponent)
    }

    /**
     method which creates an instance of CGContext

     - parameter width: The width, in pixels, of the required bitmap.
     - parameter height: The height, in pixels, of the required bitmap.
     - parameter bitmapInfo: Constants that specify whether the bitmap should contain an alpha channel,
     the alpha channel’s relative location in a pixel,
     and information about whether the pixel components are floating-point or integer values.
     - parameter colorSpace: The color space to use for the bitmap context.
     - parameter bitsPerComponent: The number of bits to use for each component of a pixel in memory.
     */
    public static func create(width: Int,
                              height: Int,
                              bitmapInfo: CGBitmapInfo = alphaBitmapInfo,
                              colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB(),
                              bitsPerComponent: Int = 8) -> CGContext? {

        return CGContext(data: nil,
                         width: width,
                         height: height,
                         bitsPerComponent: bitsPerComponent,
                         bytesPerRow: 0,
                         space: colorSpace,
                         bitmapInfo: bitmapInfo.rawValue)
    }
    
}
