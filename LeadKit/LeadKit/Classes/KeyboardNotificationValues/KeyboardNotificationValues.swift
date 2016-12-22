//
//  KeyboardNotificationValues.swift
//  LeadKit
//
//  Created by Ivan Smolin on 22/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public class KeyboardNotificationValues {

    public let sizeBegin: CGSize
    public let sizeEnd: CGSize
    public let isLocal: Bool

    public init(sizeBegin: CGSize, sizeEnd: CGSize, isLocal: Bool) {
        self.sizeBegin = sizeBegin
        self.sizeEnd = sizeEnd
        self.isLocal = isLocal
    }

}

public extension KeyboardNotificationValues {

    public convenience init(notification: Notification) throws {
        guard let sizeBegin = notification.keyboardFrameBegin?.size,
            let sizeEnd = notification.keyboardFrameEnd?.size,
            let isLocal = notification.keyboardIsLocal else {

                throw KeyboardNotificationValuesError.failedToInit(fromNotification: notification)
        }

        self.init(sizeBegin: sizeBegin, sizeEnd: sizeEnd, isLocal: isLocal)
    }
    
}
