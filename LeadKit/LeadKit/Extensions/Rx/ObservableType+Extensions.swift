//
//  ObservableType+Extensions.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import RxSwift

public extension ObservableType {
    public func subcribeOnBackgroundScheduler() -> Observable<E> {
        return self.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }
    
    public func observeOnBackgroundScheduler() -> Observable<E> {
        return self.observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }
    
    public func subcribeOnMainScheduler() -> Observable<E> {
        return self.subscribeOn(MainScheduler.instance)
    }
    
    public func observeOnMainScheduler() -> Observable<E> {
        return self.observeOn(MainScheduler.instance)
    }
}
