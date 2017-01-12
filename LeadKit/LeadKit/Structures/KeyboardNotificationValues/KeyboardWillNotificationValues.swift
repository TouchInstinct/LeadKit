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
        let notificationValues = KeyboardNotificationValues(notification: notification)

        guard let sizeBegin = notificationValues.frameBegin?.size,
            let sizeEnd = notificationValues.frameEnd?.size,
            let animationDuration = notificationValues.animationDuration,
            let animationCurve = notificationValues.animationCurve,
            let isLocal = notificationValues.isLocal else {

                throw KeyboardNotificationValuesError.failedToInit(fromNotification: notification)
        }

        self.sizeBegin = sizeBegin
        self.sizeEnd = sizeEnd
        self.animationDuration = animationDuration
        self.animationCurve = animationCurve
        self.isLocal = isLocal
    }
    
}
