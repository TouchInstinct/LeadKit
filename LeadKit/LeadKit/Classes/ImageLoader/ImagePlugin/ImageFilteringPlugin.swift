//
//  ImageFilteringPlugin.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import AlamofireImage
import RxSwift

public class ImageFilteringPlugin: ImagePluginType {
    public enum FilterError: Error {
        case unknownError(description: String)
    }
    
    public typealias FitlerParamsType = [String : Any]
    
    private let filterName: String
    private let filterParams: FitlerParamsType?
    
    public var pluginKey: String {
        var resultKey = filterName
        if let filterParams = filterParams {
            resultKey += filterParams.description
        }
        
        return resultKey
    }
    
    public func perform(image: UIImage) -> Observable<UIImage> {
        return Observable.deferred({ () -> Observable<UIImage> in
            guard let reusltImage = image.af_imageFiltered(withCoreImageFilter: self.filterName, parameters: self.filterParams) else {
                throw FilterError.unknownError(description: "ImageFilterPlugin failed with filter named \(self.filterName)")
            }
            
            return Observable.just(reusltImage)
        })
            .subcribeOnBackgroundScheduler()
    }
    
    public init(name: String, params: FitlerParamsType? = nil) {
        filterName = name
        filterParams = params
    }
}


public extension ImageOperation {
    public func filter(name: String, params: ImageFilteringPlugin.FitlerParamsType? = nil) -> ImageOperation {
        return ImagePluginOperation(originalOperation: self, plugin: ImageFilteringPlugin(name: name, params: params))
    }
}
