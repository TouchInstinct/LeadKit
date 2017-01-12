//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
                return .willShow(notificationValues: try KeyboardWillNotificationValues(notification: notification))
        }

        let didShowObservable = rxNotificationCenter.notification(.UIKeyboardDidShow)
            .map { notification -> KeyboardNotification in
                return .didShow(notificationValues: try KeyboardDidNotificationValues(notification: notification))
        }

        let willHideObservable = rxNotificationCenter.notification(.UIKeyboardWillHide)
            .map { notification -> KeyboardNotification in
                return .willHide(notificationValues: try KeyboardWillNotificationValues(notification: notification))
        }

        let didHideObservable = rxNotificationCenter.notification(.UIKeyboardDidHide)
            .map { notification -> KeyboardNotification in
                return .didHide(notificationValues: try KeyboardDidNotificationValues(notification: notification))
        }

        let willChangeFrameObservable = rxNotificationCenter.notification(.UIKeyboardWillChangeFrame)
            .map { notification -> KeyboardNotification in
                return .willChangeFrame(notificationValues: try KeyboardWillNotificationValues(notification: notification))
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
