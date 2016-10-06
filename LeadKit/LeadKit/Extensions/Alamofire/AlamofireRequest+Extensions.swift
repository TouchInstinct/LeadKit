//
//  AlamofireRequest+Extensions.swift
//  LeadKit
//
//  Created by Ivan Smolin on 04/08/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Alamofire
import RxSwift
import Mapper
import RxAlamofire
import struct RxCocoa.Reactive

public extension Reactive where Base: DataRequest {

    /**
     method which serialize response into target object

     - returns: Observable with HTTP URL Response and target object
     */
    func apiResponse<T: Mappable>() -> Observable<(HTTPURLResponse, T)> {
        let mapperSerializer = DataResponseSerializer<T> { request, response, data, error in
            if let err = error {
                return .failure(RequestError.network(error: err))
            }

            let jsonResponseSerializer = DataRequest.jsonResponseSerializer()
            let result = jsonResponseSerializer.serializeResponse(request, response, data, error)

            switch result {
            case .success(let value):
                if let responseObject = value as? NSDictionary, let mappedObject = T.from(responseObject) {
                    return .success(mappedObject)
                } else {
                    let failureReason = "JSON could not be mapped into response object. JSON: \(value)"

                    return .failure(RequestError.mapping(reason: failureReason))
                }
            case .failure(let error):
                return .failure(RequestError.jsonSerialization(error: error))
            }
        }

        return responseResult(responseSerializer: mapperSerializer)
    }

}
