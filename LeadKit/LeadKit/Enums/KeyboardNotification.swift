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
