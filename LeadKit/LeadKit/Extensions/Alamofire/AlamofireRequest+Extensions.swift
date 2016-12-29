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
    /// - Parameter mappingQueueQoS: QoS of underlying scheduler queue on which mapping will be executed
    /// - Returns: Observable with HTTP URL Response and target object
    func apiResponse<T: ImmutableMappable>(mappingQueueQoS: DispatchQoS = .default) -> Observable<(HTTPURLResponse, T)> {
        return responseJSON()
            .map { resp, value in
                let json = try cast(value) as [String: Any]

                return (resp, try T(JSON: json))
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: mappingQueueQoS))
    }

    /// Method which serializes response into target object
    ///
    /// - Parameter mappingQueueQoS: QoS of underlying scheduler queue on which mapping will be executed
    /// - Returns: Observable with HTTP URL Response and target object
    func apiResponse<T: ObservableMappable>(mappingQueueQoS: DispatchQoS = .default) -> Observable<(HTTPURLResponse, T)>
        where T.ModelType == T {

        return responseJSON()
            .flatMap { resp, value -> Observable<(HTTPURLResponse, T)> in
                let json = try cast(value) as [String: Any]

                return T.createFrom(map: Map(mappingType: .fromJSON, JSON: json))
                    .map { (resp, $0) }
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: mappingQueueQoS))
            }
    }

}
