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

public extension Alamofire.Request {

    /**
     method which serialize response into target object

     - returns: Observable with HTTP URL Response and target object
     */
    func apiResponse<T: Mappable>() -> Observable<(NSHTTPURLResponse, T)> {
        let mapperSerializer = ResponseSerializer<T, RequestError> { request, response, data, error in
            if let err = error {
                return .Failure(.Network(error: err))
            }

            let jsonResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, error)

            switch result {
            case .Success(let value):
                if let responseObject = value as? NSDictionary, mappedObject = T.from(responseObject) {
                    return .Success(mappedObject)
                } else {
                    return .Failure(.Mapping(reason: "JSON could not be mapped into response object. JSON: \(value)"))
                }
            case .Failure(let error):
                return .Failure(.JSONSerialization(error: error))
            }
        }

        return rx_responseResult(responseSerializer: mapperSerializer)
    }

}
