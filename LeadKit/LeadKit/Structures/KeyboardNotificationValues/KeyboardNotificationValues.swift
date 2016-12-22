//
//  KeyboardNotificationValues.swift
//  LeadKit
//
//  Created by Ivan Smolin on 22/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

internal struct KeyboardNotificationValues {

    let frameBegin: CGRect?
    let frameEnd: CGRect?
    let animationDuration: TimeInterval?
    let animationCurve: UIViewAnimationCurve?
    let isLocal: Bool?

    init(notification: Notification) {
        frameBegin = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        frameEnd = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue

        if let rawValue = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.intValue {
            animationCurve = UIViewAnimationCurve(rawValue: rawValue)
        } else {
            animationCurve = nil
        }

        isLocal = (notification.userInfo?[UIKeyboardIsLocalUserInfoKey] as? NSNumber)?.boolValue
    }

}
