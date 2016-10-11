//
//  RequestError.swift
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
public enum RequestError: Error {

    case network(error: Error)
    case jsonSerialization(error: Error)
    case mapping(error: Error)

}
