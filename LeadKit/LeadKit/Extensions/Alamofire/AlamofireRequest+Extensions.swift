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

public enum ApiResponseMappingError: Error {

    case incorrectValueType(message: String)

}

public extension Reactive where Base: DataRequest {

    /**
     method which serialize response into target object

     - returns: Observable with HTTP URL Response and target object
     */
    func apiResponse<T: ImmutableMappable>() -> Observable<(HTTPURLResponse, T)> {
        return responseJSON().map { resp, value in
            if let json = value as? [String: Any] {
                return (resp, try T(map: Map(mappingType: .fromJSON, JSON: json)))
            } else {
                let failureReason = "Value has incorrect type: \(type(of: value)), expected: [String: Any]"

                throw ApiResponseMappingError.incorrectValueType(message: failureReason)
            }
        }
    }

}
