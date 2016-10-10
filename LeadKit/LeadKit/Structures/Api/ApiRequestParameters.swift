//
//  ApiRequestParameters.swift
//  LeadKit
//
//  Created by Ivan Smolin on 27/07/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Alamofire
import Mapper
import RxSwift

/**
 *  Struct which keeps base parameters required for api request
 */
public struct ApiRequestParameters {

    let method: HTTPMethod
    let url: URLConvertible
    let parameters: Parameters?
    let encoding: ParameterEncoding
    let headers: HTTPHeaders?

    public init(url: URLConvertible,
                method: HTTPMethod = .get,
                parameters: Parameters? = nil,
                encoding: ParameterEncoding = URLEncoding.default,
                headers: HTTPHeaders? = nil) {

        self.method = method
        self.url = url
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }

}
