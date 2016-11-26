//
//  ImageOperation.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import RxSwift

public class ImageOperation: ObservableType {
    public typealias E = UIImage
    
    open var _imageSource: Observable<UIImage> {
        abstractMethod("_imageSource")
    }
    
    open var _performer: ImageOperationPerformer {
        abstractMethod("_performer")
    }
    
    open var _cachingKey: String {
        abstractMethod("_cachingKey")
    }
    
    open func _preparePerformerObservable(performObservable: Observable<UIImage>) -> Observable<UIImage> {
        return performObservable
    }
    
    public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == UIImage {
        return _preparePerformerObservable(performObservable: _performer.performImageOperation(operation: self))
            .subscribe(observer)
    }
}
