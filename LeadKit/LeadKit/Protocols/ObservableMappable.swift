//
//  ObservableMappable.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import ObjectMapper
import RxSwift

/// Protocol for concurrent model mapping
public protocol ObservableMappable {

    associatedtype ModelType

    static func createFrom(map: Map) -> Observable<ModelType>

}
