//
//  CursorError.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// A type representing an possible errors that can be thrown during working with cursor object
///
/// - busy: cursor is currently processing another request
/// - exhausted: cursor did load all available results
/// - deallocated: cursor was deallocated during processing request
public enum CursorError: Error {

    case busy
    case exhausted
    case deallocated

}
