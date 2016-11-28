//
//  ImageResizingPlugin.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import AlamofireImage
import RxSwift

public class ImageResizingPlugin: ImagePluginType {
    public enum Mode: String {
        case scale
        case aspectFit
        case aspectFill
        
        static var `default`: Mode {
            return .scale
        }
    }
    
    private let mode: Mode
    private let size: CGSize
    
    public var pluginKey: String {
        return mode.rawValue + String(describing: size.width) + String(describing: size.height)
    }
    
    public func perform(image: UIImage) -> Observable<UIImage> {
        return Observable.deferred({ () -> Observable<UIImage> in
            return Observable.just(self.beginPerform(image: image))
        })
            .subcribeOnBackgroundScheduler()
    }
    
    private func beginPerform(image: UIImage) -> UIImage {
        switch mode {
        case .scale:
            return image.af_imageScaled(to: size)
        case .aspectFit:
            return image.af_imageAspectScaled(toFit: size)
        case .aspectFill:
            return image.af_imageAspectScaled(toFill: size)
        }
    }
    
    public init(size: CGSize, mode: Mode = .default) {
        self.size = size
        self.mode = mode;
    }
}

public extension ImageOperation {
    public func resize(size: CGSize, mode: ImageResizingPlugin.Mode = .default) -> ImageOperation {
        return ImagePluginOperation(originalOperation: self, plugin: ImageResizingPlugin(size: size, mode: mode))
    }
}
