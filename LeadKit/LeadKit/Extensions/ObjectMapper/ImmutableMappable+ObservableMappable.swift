//
//  ImmutableMappable+ObservableMappable.swift
//  LeadKit
//
//  Created by Ivan Smolin on 26/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import ObjectMapper
import RxSwift

public extension ObservableMappable where Self: ImmutableMappable, ModelType == Self {

    /// Default implementation of ObservableMappable protocol for ImmutableMappable protocol
    ///
    /// - Parameter map: ObjectMapper.Map object
    /// - Returns: Observable with value of ModelType(map: ObjectMapper.Map)
    /// - Throws: error of ModelType(map: ObjectMapper.Map)
    static func createFrom(map: Map) throws -> Observable<Self> {
        return Observable.just(try ModelType(map: map))
    }

}
