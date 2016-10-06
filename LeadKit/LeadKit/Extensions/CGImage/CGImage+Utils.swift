//
//  CGImage+Utils.swift
//  LeadKit
//
//  Created by Ivan Smolin on 05/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import CoreGraphics

// The bitmapInfo value are hard-coded to prevent an "unsupported parameter combination" error

public let alphaBitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
public let opaqueBitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.none.rawValue)

public enum ImageContentMode {
    case scaleToFill, scaleAspectFit, scaleAspectFill
}

public extension CGImage {

    /**
     - returns: bounds of image.
     */
    var bounds: CGRect {
        return CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
    }

}
