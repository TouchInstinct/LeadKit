//
//  UIImageView+ImageLoader.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import RxSwift

public extension ImageResizingPlugin.Mode {
    public static func fromUIContentMode(contentMode: UIViewContentMode) -> ImageResizingPlugin.Mode {
        switch contentMode {
        case .scaleAspectFill:
            return .aspectFill
        case .scaleAspectFit:
            return .aspectFit
        default:
            return .scale
        }
    }
}

public extension UIImageView {
    public func loadImage<TKey: CustomStringConvertible>(key: TKey, loader: ImageLoader<TKey>, resizeImage: Bool = true,
                          placeholder: UIImage? = nil) -> ImageOperation {
        
        var resultOperation = loader.loadImage(key: key)
        
        if resizeImage {
            resultOperation = resultOperation.resize(size: frame.size, mode: ImageResizingPlugin.Mode.fromUIContentMode(contentMode: contentMode))
        }
        
        resultOperation = resultOperation.performWith({ (observable) -> Observable<UIImage> in
            var resultObservable = observable.observeOnMainScheduler()
                .do(onNext: { [weak self] (image) in
                    self?.image = image
                })
                .takeUntil(self.rx.deallocated)
            
            if let placeholder = placeholder {
                resultObservable = resultObservable.startWith(placeholder)
            }
            
            return resultObservable
        })
        
        return resultOperation
    }
}
