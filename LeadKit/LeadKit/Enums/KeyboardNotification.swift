//
//  KeyboardNotification.swift
//  LeadKit
//
//  Created by Ivan Smolin on 12/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// A type representing an possible keyboard notifications emitted by notification center
/// with accociated keyboard notification values
///
/// - willShow: UIKeyboardWillShow notification
/// - didShow: UIKeyboardDidShow notification
/// - willHide: UIKeyboardWillHide notification
/// - didHide: UIKeyboardDidHide notification
/// - willChangeFrame: UIKeyboardWillChangeFrame notification
/// - didChangeFrame: UIKeyboardDidChangeFrame notification
public enum KeyboardNotification {

    case willShow(notificationValues: KeyboardWillNotificationValues)
    case didShow(notificationValues: KeyboardDidNotificationValues)

    case willHide(notificationValues: KeyboardWillNotificationValues)
    case didHide(notificationValues: KeyboardDidNotificationValues)

    case willChangeFrame(notificationValues: KeyboardWillNotificationValues)
    case didChangeFrame(notificationValues: KeyboardDidNotificationValues)
    
}
