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

    let method: Alamofire.Method
    let url: URLStringConvertible
    let parameters: [String: AnyObject]?
    let encoding: ParameterEncoding
    let headers: [String: String]?

    public init(method: Alamofire.Method,
                url: URLStringConvertible,
                parameters: [String: AnyObject]? = nil,
                encoding: ParameterEncoding = .URL,
                headers: [String: String]? = nil) {

        self.method = method
        self.url = url
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }

}
