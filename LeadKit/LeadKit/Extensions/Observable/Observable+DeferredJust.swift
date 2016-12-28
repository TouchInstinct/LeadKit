//
//  Observable+DeferredJust.swift
//  LeadKit
//
//  Created by Ivan Smolin on 28/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import RxSwift

public extension Observable {

    /// Returns an observable sequence that invokes the specified factory function whenever a new observer subscribes.
    ///
    /// - Parameter elementFactory: Element factory function to invoke for each observer
    /// that subscribes to the resulting sequence.
    /// - Returns: An observable sequence whose observers trigger an invocation of the given element factory function.
    static func deferredJust(_ elementFactory: @escaping () throws -> Element) -> Observable<Element> {
        return create { (observer) -> Disposable in
            do {
                observer.onNext(try elementFactory())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }

            return Disposables.create()
        }
    }
    
}
