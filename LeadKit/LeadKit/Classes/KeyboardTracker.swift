//
//  KeyboardTracker.swift
//  LeadKit
//
//  Created by Николай Ашанин on 15.09.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public class KeyboardTracker {

    private enum KeyboardStatus {
        case Hidden
        case Showing
        case Shown
    }

    private var keyboardStatus: KeyboardStatus = .Hidden
    private let view: UIView
    private let inputContainerBottomConstraint: NSLayoutConstraint
    var trackingView: UIView {
        return keyboardTrackerView
    }
    private lazy var keyboardTrackerView: KeyboardTrackingView = {
        let trackingView = KeyboardTrackingView()
        trackingView.positionChangedCallback = { [weak self] in
            self?.layoutInputAtTrackingViewIfNeeded()
        }
        return trackingView
    }()

    public var isTracking = false
    public var inputContainer: UIView
    private var notificationCenter: NSNotificationCenter

    init(viewController: UIViewController, inputContainer: UIView,
         inputContainerBottomContraint: NSLayoutConstraint, notificationCenter: NSNotificationCenter) {
        view = viewController.view
        inputContainer = inputContainer
        inputContainerBottomConstraint = inputContainerBottomContraint
        self.notificationCenter = notificationCenter
        self.notificationCenter.addObserver(self,
                                            selector: #selector(KeyboardTracker.keyboardWillShow(_:)),
                                            name: UIKeyboardWillShowNotification, object: nil)
        self.notificationCenter.addObserver(self,
                                            selector: #selector(KeyboardTracker.keyboardDidShow(_:)),
                                            name: UIKeyboardDidShowNotification, object: nil)
        self.notificationCenter.addObserver(self,
                                            selector: #selector(KeyboardTracker.keyboardWillHide(_:)),
                                            name: UIKeyboardWillHideNotification, object: nil)
        self.notificationCenter.addObserver(self,
                                            selector: #selector(KeyboardTracker.keyboardWillChangeFrame(_:)),
                                            name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    func startTracking() {
        isTracking = true
    }

    func stopTracking() {
        isTracking = false
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard isTracking else {
            return
        }
        let bottomConstraint = bottomConstraintFromNotification(notification)
        // Some keyboards may report initial willShow/DidShow notifications with invalid positions
        guard bottomConstraint > 0 else {
            return
        }
        keyboardStatus = .Showing
        inputContainerBottomConstraint.constant = bottomConstraint
        view.layoutIfNeeded()
        adjustTrackingViewSizeIfNeeded()
    }

    @objc
    private func keyboardDidShow(notification: NSNotification) {
        guard self.isTracking else {
            return
        }
        let bottomConstraint = bottomConstraintFromNotification(notification)
        // Some keyboards may report initial willShow/DidShow notifications with invalid positions
        guard bottomConstraint > 0 else {
            return
        }
        keyboardStatus = .Shown
        inputContainerBottomConstraint.constant = bottomConstraint
        view.layoutIfNeeded()
        layoutTrackingViewIfNeeded()
    }

    @objc
    private func keyboardWillChangeFrame(notification: NSNotification) {
        guard isTracking else {
            return
        }
        let bottomConstraint = bottomConstraintFromNotification(notification)
        if bottomConstraint == 0 {
            keyboardStatus = .Hidden
            layoutInputAtBottom()
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        guard isTracking else {
            return
        }
        keyboardStatus = .Hidden
        layoutInputAtBottom()
    }

    private func bottomConstraintFromNotification(notification: NSNotification) -> CGFloat {
        guard let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else {
            return 0
        }
        guard rect.height > 0 else {
            return 0
        }
        let rectInView = view.convertRect(rect, fromView: nil)
        guard rectInView.maxY >= view.bounds.height else {
            return 0 // Undocked keyboard
        }
        return max(0, view.bounds.height - rectInView.minY - trackingView.bounds.height)
    }

    private func bottomConstraintFromTrackingView() -> CGFloat {
        let trackingViewRect = view.convertRect(keyboardTrackerView.bounds, fromView: keyboardTrackerView)
        return view.bounds.height - trackingViewRect.maxY
    }

    func layoutTrackingViewIfNeeded() {
        guard isTracking && keyboardStatus == .Shown else {
            return
        }
        adjustTrackingViewSizeIfNeeded()
    }

    private func adjustTrackingViewSizeIfNeeded() {
        let inputContainerHeight = inputContainer.bounds.height
        let trackerViewHeight = trackingView.bounds.height
        if trackerViewHeight != inputContainerHeight {
            keyboardTrackerView.bounds = CGRect(origin: CGPoint.zero,
                                                size: CGSize(width: self.keyboardTrackerView.bounds.width,
                                                            height: inputContainerHeight))
        }
    }

    private func layoutInputAtBottom() {
        keyboardTrackerView.bounds = CGRect(origin: CGPoint.zero,
                                            size: CGSize(width: keyboardTrackerView.bounds.width,
                                                        height: 0))
        inputContainerBottomConstraint.constant = 0
        view.layoutIfNeeded()
    }

    func layoutInputAtTrackingViewIfNeeded() {
        guard isTracking && keyboardStatus == .Shown else {
            return
        }
        let newBottomConstraint = bottomConstraintFromTrackingView()
        inputContainerBottomConstraint.constant = newBottomConstraint
        view.layoutIfNeeded()
    }

}

private class KeyboardTrackingView: UIView {

    private static let centerKey = "center"

    var positionChangedCallback: (() -> Void)?
    var observedView: UIView?

    deinit {
        if let observedView = self.observedView {
            observedView.removeObserver(self, forKeyPath: KeyboardTrackingView.centerKey)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        autoresizingMask = .FlexibleHeight
        userInteractionEnabled = false
        backgroundColor = UIColor.clearColor()
        hidden = true
    }

    override var bounds: CGRect {
        didSet {
            if oldValue.size != bounds.size {
                invalidateIntrinsicContentSize()
            }
        }
    }

    private override func intrinsicContentSize() -> CGSize {
        return bounds.size
    }

    override func willMoveToSuperview(newSuperview: UIView?) {
        if let observedView = self.observedView {
            observedView.removeObserver(self, forKeyPath: KeyboardTrackingView.centerKey)
            self.observedView = nil
        }

        if let newSuperview = newSuperview {
            newSuperview.addObserver(self, forKeyPath: KeyboardTrackingView.centerKey, options: [.New, .Old], context: nil)
            self.observedView = newSuperview
        }

        super.willMoveToSuperview(newSuperview)
    }

    private override func observeValueForKeyPath(keyPath: String?,
                                                 ofObject object: AnyObject?,
                                                          change: [String: AnyObject]?,
                                                          context: UnsafeMutablePointer<Void>) {
        guard let object = object, superview = self.superview else {
            return
        }
        if object === superview {
            guard let sChange = change else {
                return
            }
            let oldCenter = (sChange[NSKeyValueChangeOldKey] as? NSValue)?.CGPointValue()
            let newCenter = (sChange[NSKeyValueChangeNewKey] as? NSValue)?.CGPointValue()
            if oldCenter != newCenter {
                self.positionChangedCallback?()
            }
        }
    }
    
}
