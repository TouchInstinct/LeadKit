//
//  AlamofireRequest+Extensions.swift
//  LeadKit
//
//  Created by Ivan Smolin on 04/08/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Alamofire
import RxSwift
import RxAlamofire
import struct RxCocoa.Reactive
import Convertible

public extension Reactive where Base: DataRequest {

    /**
     method which serialize response into target object

     - returns: Observable with HTTP URL Response and target object
     */
    func apiResponse<T: Convertible>(convertibleOptions: [ConvertibleOption] = []) -> Observable<(HTTPURLResponse, T)> {
        let mapperSerializer = DataResponseSerializer<T> { request, response, data, error in
            if let err = error {
                return .failure(RequestError.network(error: err))
            }

            let jsonResponseSerializer = DataRequest.jsonResponseSerializer()
            let result = jsonResponseSerializer.serializeResponse(request, response, data, error)

            switch result {
            case .success(let value):
                do {
                    return .success(try T.initializeWithJson(JsonValue(object: value), options: convertibleOptions))
                } catch let err {
                    return .failure(RequestError.mapping(error: err))
                }
            case .failure(let error):
                return .failure(RequestError.jsonSerialization(error: error))
            }
        }

        return responseResult(responseSerializer: mapperSerializer)
    }

}
