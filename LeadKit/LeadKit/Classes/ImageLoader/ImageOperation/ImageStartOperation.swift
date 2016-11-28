//
//  ImageStartOperation.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import RxSwift

public class ImageStartOperation: ImageOperation, ImageOperationPerformer {
    public override var _imageSource: Observable<UIImage> {
        return source
    }
    
    public override var _performer: ImageOperationPerformer {
        return self
    }
    
    public override var _cachingKey: String {
        return key
    }
    
    public func performImageOperation(operation: ImageOperation) -> Observable<UIImage> {
        return operation._imageSource
    }
    
    private let source: Observable<UIImage>
    private let key: String
    
    public init(source: Observable<UIImage>, key: String? = nil) {
        self.key = key ?? String()
        self.source = source
    }
}

public extension UIImage {
    public func asImageOperation(key: String? = nil) -> ImageOperation {
        return Observable.just(self).asImageOperation()
    }
}

public extension ImageOperation {
    public func asImageOperation(key: String? = nil) -> ImageOperation {
        return self
    }
}

public extension ObservableConvertibleType where E == UIImage {
    public func asImageOperation(key: String? = nil) -> ImageOperation {
        return ImageStartOperation(source: self.asObservable(), key: key)
    }
}
