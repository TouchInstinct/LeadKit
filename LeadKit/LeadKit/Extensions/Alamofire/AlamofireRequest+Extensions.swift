//
//  AlamofireRequest+Extensions.swift
//  LeadKit
//
//  Created by Ivan Smolin on 04/08/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Alamofire
import RxSwift
import ObjectMapper
import RxAlamofire

public extension Reactive where Base: DataRequest {

    /// Method which serializes response into target object
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func apiResponse<T: ImmutableMappable>(mappingQueue: DispatchQueue = DispatchQueue.global())
        -> Observable<(HTTPURLResponse, T)> {

        return responseJSONOnQueue(mappingQueue)
            .map { resp, value in
                let json = try cast(value) as [String: Any]

                return (resp, try T(JSON: json))
            }
    }

    /// Method which serializes response into target object
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func apiResponse<T: ObservableMappable>(mappingQueue: DispatchQueue = DispatchQueue.global())
        -> Observable<(HTTPURLResponse, T)> where T.ModelType == T {

            return responseJSONOnQueue(mappingQueue)
            .flatMap { resp, value -> Observable<(HTTPURLResponse, T)> in
                let json = try cast(value) as [String: Any]

                return T.createFrom(map: Map(mappingType: .fromJSON, JSON: json))
                    .map { (resp, $0) }
            }
    }

    internal func responseJSONOnQueue(_ queue: DispatchQueue) -> Observable<(HTTPURLResponse, Any)> {
        return responseResult(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer(options: .allowFragments))
    }

}
