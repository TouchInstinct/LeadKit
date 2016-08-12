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

}
