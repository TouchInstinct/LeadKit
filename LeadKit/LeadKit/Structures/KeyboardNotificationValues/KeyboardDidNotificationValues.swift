//
//  KeyboardDidNotificationValues.swift
//  LeadKit
//
//  Created by Ivan Smolin on 12/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

/// Struct which keeps values from one of those notifications:
/// UIKeyboardDidShow, UIKeyboardDidHide, UIKeyboardDidChangeFrame
public struct KeyboardDidNotificationValues {

    let sizeBegin: CGSize
    let sizeEnd: CGSize
    let isLocal: Bool

    // Animation key/value pairs are only available for the "will" family of notification. (UIWindow.h)
    
}

public extension KeyboardDidNotificationValues {

    init(notification: Notification) throws {
        guard let sizeBegin = notification.keyboardFrameBegin?.size,
            let sizeEnd = notification.keyboardFrameEnd?.size,
            let isLocal = notification.keyboardIsLocal else {

                throw KeyboardNotificationValuesError.failedToInit(fromNotification: notification)
        }

        self.sizeBegin = sizeBegin
        self.sizeEnd = sizeEnd
        self.isLocal = isLocal
    }
    
}
