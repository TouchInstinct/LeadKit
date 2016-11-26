//
//  NetworkImageSource.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import RxSwift
import Alamofire
import AlamofireImage

public class NetworkImageSource<TKey: URLConvertible>: ImageSourceType where TKey: CustomStringConvertible {
    public typealias KeyType = TKey
    
    private let sessionManager: SessionManager
    
    public func loadImage(_ key: KeyType) -> Observable<UIImage> {
        return Observable.deferred({ () -> Observable<UIImage> in
            return self.beginLoadImage(try key.asURL())
        })
    }
    
    private func beginLoadImage(_ url: URL) -> Observable<UIImage> {
        return Observable.create({ (observer) -> Disposable in
            let request = self.sessionManager.request(url)
                .responseImage(completionHandler: { (response) in
                    switch response.result {
                    case .success(let image):
                        observer.onNext(image)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
    
    public init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }
}
