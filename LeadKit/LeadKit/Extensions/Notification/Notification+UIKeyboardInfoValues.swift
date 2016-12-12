//
//  Notification+UIKeyboardInfoValues.swift
//  LeadKit
//
//  Created by Ivan Smolin on 12/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public extension Notification {

    /// CGRect value for UIKeyboardFrameBeginUserInfoKey or nil
    var keyboardFrameBegin: CGRect? {
        return (userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
    }

    /// CGRect value for UIKeyboardFrameEndUserInfoKey or nil
    var keyboardFrameEnd: CGRect? {
        return (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }

    /// TimeInterval value for UIKeyboardAnimationDurationUserInfoKey or nil
    var keyboardAnimationDuration: TimeInterval? {
        return (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    }

    /// UIViewAnimationCurve value for UIKeyboardAnimationDurationUserInfoKey or nil
    var keyboardAnimationCurve: UIViewAnimationCurve? {
        if let rawValue = (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.intValue {
            return UIViewAnimationCurve(rawValue: rawValue)
        }

        return nil
    }

    /// Bool value for UIKeyboardIsLocalUserInfoKey or nil
    var keyboardIsLocal: Bool? {
        return (userInfo?[UIKeyboardIsLocalUserInfoKey] as? NSNumber)?.boolValue
    }
    
}
