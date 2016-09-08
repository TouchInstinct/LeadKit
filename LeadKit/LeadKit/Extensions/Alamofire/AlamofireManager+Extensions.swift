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

public extension Alamofire.Manager {

    /**
     method which executes request with given api parameters

     - parameter apiParameters: api parameters to pass Alamofire

     - returns: Observable with request 
     */
    func apiRequest(apiParameters: ApiRequestParameters) -> Observable<Request> {
        return rx_request(apiParameters.method,
                          apiParameters.url,
                          parameters: apiParameters.parameters,
                          encoding: apiParameters.encoding,
                          headers: apiParameters.headers)
    }

}
