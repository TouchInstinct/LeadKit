//
//  ApiError.swift
//  LeadKit
//
//  Created by Ivan Smolin on 04/08/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

/**
 enum which describes type of api request error

 - Network:             network error
 - JSONSerialization:   JSON serialization error
 - ObjectSerialization: object mapping error
 */
public enum RequestError: ErrorType {

    case Network(error: NSError)
    case JSONSerialization(error: NSError)
    case Mapping(reason: String)
    
}
