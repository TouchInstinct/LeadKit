//
//  ImageOperationWrapper.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import RxSwift

public class ImageOperationWrapper: ImageOperation {
    open override var _imageSource: Observable<UIImage> {
        return _prepareWorkingObservable(workingObservable: originalOperation._imageSource)
    }
    
    open override var _performer: ImageOperationPerformer {
        return originalOperation._performer
    }
    
    open override var _cachingKey: String {
        return _prepareCachingKey(cachingKey: originalOperation._cachingKey)
    }
    
    open func _prepareWorkingObservable(workingObservable: Observable<UIImage>) -> Observable<UIImage> {
        return workingObservable
    }
    
    open override func _preparePerformerObservable(performObservable: Observable<UIImage>) -> Observable<UIImage> {
        return super._preparePerformerObservable(performObservable:
            originalOperation._preparePerformerObservable(performObservable: performObservable))
    }
    
    open func _prepareCachingKey(cachingKey: String) -> String {
        return cachingKey
    }
    
    private let originalOperation: ImageOperation
    
    public init(originalOperation: ImageOperation) {
        self.originalOperation = originalOperation
    }
}
