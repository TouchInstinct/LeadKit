//
//  AlamofireManager+Extensions.swift
//  LeadKit
//
//  Created by Ivan Smolin on 04/08/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper

public extension Alamofire.SessionManager {

    /**
     method which executes request with given api parameters

     - parameter requestParameters: api parameters to pass Alamofire

     - returns: Observable with request 
     */
    func apiRequest(requestParameters: ApiRequestParameters) -> Observable<DataRequest> {
        return RxAlamofire.request(requestParameters.method,
                                   requestParameters.url,
                                   parameters: requestParameters.parameters,
                                   encoding: requestParameters.encoding,
                                   headers: requestParameters.headers)
    }

    /**
     method which executes request and serialize response into target object
     
     - parameter requestParameters: api parameters to pass Alamofire

     - returns: Observable with HTTP URL Response and target object
     */
    func responseModel<T: ImmutableMappable>(requestParameters: ApiRequestParameters) -> Observable<(HTTPURLResponse, T)> {
        return apiRequest(requestParameters: requestParameters).flatMap { $0.rx.apiResponse() }
    }

}
