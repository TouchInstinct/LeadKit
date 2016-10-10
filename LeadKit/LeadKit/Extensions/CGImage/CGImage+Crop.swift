//
//  CGImage+Crop.swift
//  LeadKit
//
//  Created by Ivan Smolin on 06/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import CoreGraphics

public extension CGImage {

    /**
     crop image to square from center

     - returns: cropped image
     */
    public func cropFromCenterToSquare() -> CGImage? {
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
    
}
