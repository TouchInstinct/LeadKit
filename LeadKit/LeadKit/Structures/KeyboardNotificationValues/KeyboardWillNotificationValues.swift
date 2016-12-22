//
//  KeyboardWillNotificationValues.swift
//  LeadKit
//
//  Created by Ivan Smolin on 12/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

/// Struct which keeps values from one of those notifications:
/// UIKeyboardWillShow, UIKeyboardWillHide, UIKeyboardWillChangeFrame
public struct KeyboardWillNotificationValues {

    let sizeBegin: CGSize
    let sizeEnd: CGSize
    let animationDuration: TimeInterval
    let animationCurve: UIViewAnimationCurve
    let isLocal: Bool
    
}

public extension KeyboardWillNotificationValues {

    init(notification: Notification) throws {
        guard let sizeBegin = notification.keyboardFrameBegin?.size,
            let sizeEnd = notification.keyboardFrameEnd?.size,
            let animationDuration = notification.keyboardAnimationDuration,
            let animationCurve = notification.keyboardAnimationCurve,
            let isLocal = notification.keyboardIsLocal else {

                throw KeyboardNotificationValuesError.failedToInit(fromNotification: notification)
        }

        self.sizeBegin = sizeBegin
        self.sizeEnd = sizeEnd
        self.animationDuration = animationDuration
        self.animationCurve = animationCurve
        self.isLocal = isLocal
    }
    
}
