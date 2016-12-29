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

public extension Reactive where Base: Alamofire.SessionManager {

    /// Method which executes request with given api parameters
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Returns: Observable with request
    func apiRequest(requestParameters: ApiRequestParameters) -> Observable<DataRequest> {
        return RxAlamofire.request(requestParameters.method,
                                   requestParameters.url,
                                   parameters: requestParameters.parameters,
                                   encoding: requestParameters.encoding,
                                   headers: requestParameters.headers)
    }

    /// Method which executes request and serializes response into target object
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Returns: Observable with HTTP URL Response and target object
    func responseModel<T: ImmutableMappable>(requestParameters: ApiRequestParameters) -> Observable<(HTTPURLResponse, T)> {
        return apiRequest(requestParameters: requestParameters)
            .flatMap { $0.rx.apiResponse() }
    }

    /// Method which executes request and serializes response into target object
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Returns: Observable with HTTP URL Response and target object
    func responseObservableModel<T: ObservableMappable>(requestParameters: ApiRequestParameters) ->
        Observable<(HTTPURLResponse, T)> where T.ModelType == T {

        return apiRequest(requestParameters: requestParameters)
            .flatMap { $0.rx.apiResponse() }
    }

}
