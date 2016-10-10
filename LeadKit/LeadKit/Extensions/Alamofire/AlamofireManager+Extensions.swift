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

public extension Alamofire.SessionManager {

    /**
     method which executes request with given api parameters

     - parameter apiParameters: api parameters to pass Alamofire

     - returns: Observable with request 
     */
    func apiRequest(requestParameters: ApiRequestParameters) -> Observable<DataRequest> {
        return RxAlamofire.request(requestParameters.method,
                                   requestParameters.url,
                                   parameters: requestParameters.parameters,
                                   encoding: requestParameters.encoding,
                                   headers: requestParameters.headers)
    }

}
