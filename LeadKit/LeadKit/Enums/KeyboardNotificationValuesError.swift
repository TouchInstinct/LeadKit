//
//  KeyboardNotificationValuesErrors.swift
//  LeadKit
//
//  Created by Ivan Smolin on 12/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// A type representing an possible errors that can be thrown during
/// initializing KeyboardWillNotificationValues or KeyboardDidNotificationValues
///
/// - failedToInit: failed to init notification values object from given notification
public enum KeyboardNotificationValuesError: Error {

    case failedToInit(fromNotification: Notification)
    
}
