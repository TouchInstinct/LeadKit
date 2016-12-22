//
//  NotificationCenter+Rx.swift
//  LeadKit
//
//  Created by Ivan Smolin on 12/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: NotificationCenter {

    /// Observable of KeyboardNotification subscribed to all kinds of keyboard notifications
    var keyboardNotifications: Observable<KeyboardNotification> {
        let rxNotificationCenter = NotificationCenter.default.rx

        let willShowObservable = rxNotificationCenter.notification(.UIKeyboardWillShow)
            .map { notification -> KeyboardNotification in
                return .willShow(notificationValues: try KeyboardWillNotificationValues(willNotification: notification))
        }

        let didShowObservable = rxNotificationCenter.notification(.UIKeyboardDidShow)
            .map { notification -> KeyboardNotification in
                return .didShow(notificationValues: try KeyboardDidNotificationValues(notification: notification))
        }

        let willHideObservable = rxNotificationCenter.notification(.UIKeyboardWillHide)
            .map { notification -> KeyboardNotification in
                return .willHide(notificationValues: try KeyboardWillNotificationValues(willNotification: notification))
        }

        let didHideObservable = rxNotificationCenter.notification(.UIKeyboardDidHide)
            .map { notification -> KeyboardNotification in
                return .didHide(notificationValues: try KeyboardDidNotificationValues(notification: notification))
        }

        let willChangeFrameObservable = rxNotificationCenter.notification(.UIKeyboardWillChangeFrame)
            .map { notification -> KeyboardNotification in
                return .willChangeFrame(notificationValues: try KeyboardWillNotificationValues(willNotification: notification))
        }

        let didChangeFrameObservable = rxNotificationCenter.notification(.UIKeyboardDidChangeFrame)
            .map { notification -> KeyboardNotification in
                return .didChangeFrame(notificationValues: try KeyboardDidNotificationValues(notification: notification))
        }

        return Observable.of(willShowObservable, didShowObservable,
                             willHideObservable, didHideObservable,
                             willChangeFrameObservable, didChangeFrameObservable).merge()
    }
    
}
