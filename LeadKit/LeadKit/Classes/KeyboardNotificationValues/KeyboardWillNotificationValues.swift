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
public final class KeyboardWillNotificationValues: KeyboardNotificationValues {

    public let animationDuration: TimeInterval
    public let animationCurve: UIViewAnimationCurve

    public init(sizeBegin: CGSize,
                sizeEnd: CGSize,
                isLocal: Bool,
                animationDuration: TimeInterval,
                animationCurve: UIViewAnimationCurve) {

        self.animationDuration = animationDuration
        self.animationCurve = animationCurve

        super.init(sizeBegin: sizeBegin, sizeEnd: sizeEnd, isLocal: isLocal)
    }
    
}

public extension KeyboardWillNotificationValues {

    public convenience init(willNotification: Notification) throws {
        guard let sizeBegin = willNotification.keyboardFrameBegin?.size,
            let sizeEnd = willNotification.keyboardFrameEnd?.size,
            let animationDuration = willNotification.keyboardAnimationDuration,
            let animationCurve = willNotification.keyboardAnimationCurve,
            let isLocal = willNotification.keyboardIsLocal else {

                throw KeyboardNotificationValuesError.failedToInit(fromNotification: willNotification)
        }

        self.init(sizeBegin: sizeBegin,
                  sizeEnd: sizeEnd,
                  isLocal: isLocal,
                  animationDuration: animationDuration,
                  animationCurve: animationCurve)
    }
    
}
