//
//  ImageBluringPlugin.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public class ImageBluringPlugin: ImageFilteringPlugin {
    public enum BlurType {
        case box(radius: CGFloat)
        case disc(radius: CGFloat)
        case gaussian(radius: CGFloat)
        case masked(radius: CGFloat, maskImage: UIImage)
        case median()
        case motion(radius: CGFloat, angle: CGFloat)
        
        public func filterParams() -> [String : Any] {
            var resultRadius: CGFloat?
            var resultParams = [String : Any]()
            
            switch self {
            case .box(let radius):
                resultRadius = radius
            case .disc(let radius):
                resultRadius = radius
            case .gaussian(let radius):
                resultRadius = radius
            case .masked(let radius, let maskImage):
                resultRadius = radius
                resultParams["inputMask"] = maskImage.cgImage
            case.median:
                break
            case .motion(let radius, let angle):
                resultRadius = radius
                resultParams["inputAngle"] = angle
            }
            
            if let resultRadius = resultRadius {
                resultParams["inputRadius"] = resultRadius
            }
            
            return resultParams
        }
        
        public func filterName() -> String {
            switch self {
            case .box:
                return "CIBoxBlur"
            case .disc:
                return "CIDiscBlur"
            case .gaussian:
                return "CIGaussianBlur"
            case .masked:
                return "CIMaskedVariableBlur"
            case.median:
                return "CIMedianFilter"
            case .motion:
                return "CIMotionBlur"
            }
        }
    }
    
    public init(blurType: BlurType) {
        super.init(name: blurType.filterName(), params: blurType.filterParams())
    }
}

public extension ImageOperation {
    public func blur(blurType: ImageBluringPlugin.BlurType) -> ImageOperation {
        return ImagePluginOperation(originalOperation: self, plugin: ImageBluringPlugin(blurType: blurType))
    }
}
