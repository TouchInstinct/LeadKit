//
//  Copyright (c) 2022 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import TIUIKitCore
import UIKit

@available(iOS 15, *)
open class LoggingTogglingViewController: BaseInitializableViewController {

    private var initialCenter = CGPoint()

    private(set) public var isRegisteredForShakingEvent = false

    private(set) public var isLogsPresented = false

    private(set) public var isVisibleState = true {
        didSet {
            button.isHidden = !isVisibleState
        }
    }

    public let button = UIButton()

    open override var canBecomeFirstResponder: Bool { true }

    // MARK: - Life cycle

    open override func addViews() {
        super.addViews()

        view.addSubview(button)
    }

    open override func configureLayout() {
        super.configureLayout()

        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame
        button.frame = .init(x: safeAreaFrame.minX,
                             y: safeAreaFrame.midY,
                             width: 70,
                             height: 32)
    }

    open override func bindViews() {
        super.bindViews()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))

        button.addGestureRecognizer(panGesture)
        button.addTarget(self, action: #selector(openLoggingScreenAction), for: .touchUpInside)

        // Needed for catching shaking motion
        becomeFirstResponder()
    }

    open override func configureAppearance() {
        super.configureAppearance()

        view.backgroundColor = .clear

        button.setTitle("Logs", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
    }

    // MARK: - Overrided methods

    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake, !isLogsPresented, isRegisteredForShakingEvent {
            openLoggingScreen()
        }
    }

    // MARK: - Public methods

    public func set(isRegisteredForShakingEvent: Bool) {
        self.isRegisteredForShakingEvent = isRegisteredForShakingEvent
    }

    /// Hides a button that opens logs list view controller.
    public func set(isVisible: Bool) {
        isVisibleState = isVisible
    }

    public func set(isLogsPresented: Bool) {
        self.isLogsPresented = isLogsPresented
    }

    public func openLoggingScreen() {
        present(LogsListViewController(), animated: true, completion: { [self] in
            isLogsPresented = false
        })

        isLogsPresented = true
    }

    // MARK: - Private methods

    private func clipButtonIfNeeded() {
        let viewFrame = view.safeAreaLayoutGuide.layoutFrame
        let buttonFrame = button.frame
        var x = buttonFrame.minX
        var y = buttonFrame.minY

        if buttonFrame.maxX > viewFrame.maxX {
            x = viewFrame.maxX - buttonFrame.width
            y = buttonFrame.minY

        } else if buttonFrame.minX < viewFrame.minX {
            x = viewFrame.minX
            y = buttonFrame.minY
        }

        if buttonFrame.maxY > viewFrame.maxY {
            x = buttonFrame.minX
            y = viewFrame.maxY - buttonFrame.height

        } else if buttonFrame.minY < viewFrame.minY {
            x = buttonFrame.minX
            y = viewFrame.minY
        }

        button.frame = .init(x: x,
                             y: y,
                             width: buttonFrame.width,
                             height: buttonFrame.height)
    }

    // MARK: - Actions

    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        switch gesture.state {
        case .began:
            self.initialCenter = button.center

        case .changed, .ended:
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            button.center = newCenter
            clipButtonIfNeeded()

        case .cancelled:
            button.center = initialCenter

        default:
            break
        }
    }

    @objc private func openLoggingScreenAction() {
        openLoggingScreen()
    }
}
