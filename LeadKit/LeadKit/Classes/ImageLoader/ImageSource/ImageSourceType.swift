//
//  ImageSource.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import RxSwift

public protocol ImageSourceType {
    associatedtype KeyType
    
    func loadImage(_ key: KeyType) -> Observable<UIImage>

    func asImageSource() -> ImageSource<KeyType>
}

extension ImageSourceType {
    public func asImageSource() -> ImageSource<KeyType> {
        return ImageSource(source: self)
    }
}

public class ImageSource<TKey>: ImageSourceType {
    public typealias KeyType = TKey
    public typealias ImageLoadingHandler = (KeyType) -> Observable<UIImage>
    
    private let sourceLoadImageHandler: ImageLoadingHandler
    
    public func loadImage(_ key: KeyType) -> Observable<UIImage> {
        return sourceLoadImageHandler(key)
    }
    
    public init(imageLoadingHandler: @escaping ImageLoadingHandler) {
        sourceLoadImageHandler = imageLoadingHandler
    }
    
    public convenience init<TSource: ImageSourceType>(source: TSource) where TSource.KeyType == KeyType {
        self.init(imageLoadingHandler: source.loadImage)
    }
}

extension ImageSource {
    public func asImageSource() -> ImageSource<KeyType> {
        return self
    }
}
