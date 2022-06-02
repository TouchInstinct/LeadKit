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

import Foundation
import TIFoundationUtils

@available(iOS 13.0, *)
open class DefaultCodeConfirmPresenter<ConfirmResponse: CodeConfirmResponse,
                                       RefreshResponse: CodeRefreshResponse>: CodeConfirmPresenter {

    open class Output {
        public typealias OnConfirmSuccessClosure = (ConfirmResponse) -> Void

        public var onConfirmSuccess: OnConfirmSuccessClosure

        public init(onConfirmSuccess: @escaping OnConfirmSuccessClosure) {
            self.onConfirmSuccess = onConfirmSuccess
        }
    }

    open class Requests {
        public typealias ConfirmRequestClosure = (String) async -> ConfirmResponse
        public typealias RefreshRequestClosure = () async -> RefreshResponse

        public var confirmRequest: ConfirmRequestClosure
        public var refreshRequest: RefreshRequestClosure

        public init(confirmRequest: @escaping ConfirmRequestClosure,
                    refreshRequest: @escaping RefreshRequestClosure) {

            self.confirmRequest = confirmRequest
            self.refreshRequest = refreshRequest
        }
    }

    public struct Config {
        public enum Defaults {
            public static var codeLength: Int {
                6
            }

            public static var autoRefresh: Bool {
                true
            }
        }

        public var codeLength: Int
        public var autoRefresh: Bool

        public init(codeLength: Int = Defaults.codeLength,
                    autoRefresh: Bool = Defaults.autoRefresh) {

            self.codeLength = codeLength
            self.autoRefresh = autoRefresh
        }
    }

    public var output: Output
    public var requests: Requests
    public weak var stateStorage: CodeConfirmStateStorage?
    public var config = Config()
    public var currentCodeResponse: CodeResponse

    private let codeRefreshTimer = TITimer(mode: .activeAndBackground)
    private let codeLifetimeTimer = TITimer(mode: .activeAndBackground)

    public init<Input: CodeResponse>(input: Input,
                                     output: Output,
                                     requests: Requests,
                                     stateStorage: CodeConfirmStateStorage? = nil) {

        self.currentCodeResponse = input
        self.output = output
        self.requests = requests
        self.stateStorage = stateStorage
    }

    // MARK: - Requests

    open func confirm(code: String) async {
        stateStorage?.isExecutingRequest = true

        let confirmResponse = await requests.confirmRequest(code)

        if self.isSuccessConfirm(response: confirmResponse) {
            handle(successConfirmResponse: confirmResponse)
        } else {
            handle(failureConfirmResponse: confirmResponse)
        }

        stateStorage?.isExecutingRequest = false
    }

    open func refreshCode() async {
        stateStorage?.isExecutingRequest = true

        let refreshResponse = await requests.refreshRequest()

        if isSuccessRefresh(response: refreshResponse) {
            handle(successRefreshResponse: refreshResponse)
        } else {
            handle(failureRefreshResponse: refreshResponse)
        }

        stateStorage?.isExecutingRequest = false
    }

    // MARK: - Response handling

    open func handle(successConfirmResponse response: ConfirmResponse) {
        if let additionalAuth = response.requiredAdditionalAuth {
            handle(additionalAuth: additionalAuth)
        } else {
            output.onConfirmSuccess(response)
        }
    }

    open func handle(failureConfirmResponse: ConfirmResponse) {
        stateStorage?.currentUserInput = nil

        if let remainingAttempts = failureConfirmResponse.remainingAttempts, remainingAttempts <= 0 {
            onConfirmAttemptsExhausted()
        }

        // show error message, etc.
    }

    open func handle(additionalAuth auth: String) {
        // custom subclass handling
    }

    open func onConfirmAttemptsExhausted() {
        // custom subclass handling
    }

    open func handle(successRefreshResponse response: RefreshResponse) {
        updateStateStorage(from: response)

        start(codeLifetimeTimer: codeLifetimeTimer,
              codeRefreshTimer: codeRefreshTimer,
              for: response)
    }

    func handle(failureRefreshResponse response: RefreshResponse) {
        updateStateStorage(from: response)

        // show error message, etc.
    }

    // MARK: - Response processing

    open func lifetimeDuration(of code: CodeResponse) -> Int? {
        code.validUntil?.timeIntervalSinceNow.intValue
    }

    open func nonRefreshableInterval(of code: CodeResponse) -> Int? {
        code.refreshableAfter?.timeIntervalSinceNow.intValue ?? lifetimeDuration(of: code)
    }

    open func isSuccessConfirm(response: ConfirmResponse) -> Bool {
        true
    }

    open func isSuccessRefresh(response: RefreshResponse) -> Bool {
        true
    }

    // MARK: - User actions handling

    open func inputChanged(newInput: String?) {
        stateStorage?.currentUserInput = newInput

        if let code = newInput, code.count >= config.codeLength {
            stateStorage?.isExecutingRequest = true

            Task {
                await confirm(code: code)
            }
        }
    }

    open func refreshCode() {
        stateStorage?.canRequestNewCode = false
        stateStorage?.canRefreshCodeAfter = nil

        Task {
            await refreshCode()
        }
    }

    // MARK: - View lifecycle handling

    open func viewDidPresented() {
        start(codeLifetimeTimer: codeLifetimeTimer,
              codeRefreshTimer: codeRefreshTimer,
              for: currentCodeResponse)
    }

    // MARK: - Autofill

    open func autofill(code: String, with codeId: String? = nil) {
        guard currentCodeResponse.codeId == codeId else {
            return
        }

        inputChanged(newInput: code)
    }

    // MARK: - Subclass customization

    open func start(codeLifetimeTimer: TITimer,
                    codeRefreshTimer: TITimer,
                    for code: CodeResponse) {

        start(codeRefreshTimer: codeRefreshTimer, for: code)
        start(codeLifetimeTimer: codeLifetimeTimer, for: code)
    }

    open func start(codeRefreshTimer: TITimer, for code: CodeResponse) {
        guard let nonRefreshableInterval = nonRefreshableInterval(of: code) else {
            return
        }

        codeRefreshTimer.eventHandler = { [weak self] in
            self?.updateRemaining(nonRefreshableInterval: nonRefreshableInterval,
                                                        elapsedInterval: $0)
        }
        codeRefreshTimer.start()
    }

    open func updateRemaining(nonRefreshableInterval: Int, elapsedInterval: TimeInterval) {
        let secondsLeft = nonRefreshableInterval - elapsedInterval.intValue

        stateStorage?.canRefreshCodeAfter = secondsLeft
        stateStorage?.canRequestNewCode = secondsLeft <= 0

        if secondsLeft < 0 {
            codeRefreshTimer.pause()
        }
    }

    open func start(codeLifetimeTimer: TITimer, for code: CodeResponse) {
        guard let lifetimeInterval = lifetimeDuration(of: code) else {
            return
        }

        codeLifetimeTimer.eventHandler = { [weak self] in
            self?.updateRemaining(lifetimeInterval: lifetimeInterval,
                                  elapsedInterval: $0)
        }
        codeLifetimeTimer.start()
    }

    open func updateRemaining(lifetimeInterval: Int, elapsedInterval: TimeInterval) {
        let secondsLeft = lifetimeInterval - elapsedInterval.intValue

        if secondsLeft < 0 {
            codeLifetimeTimer.pause()

            if config.autoRefresh {
                refreshCode()
            }
        }
    }

    open func updateStateStorage(from response: CodeResponse) {
        stateStorage?.remainingAttempts = response.remainingAttempts
        stateStorage?.currentUserInput = nil
        stateStorage?.canRefreshCodeAfter = nonRefreshableInterval(of: response)
        stateStorage?.canRequestNewCode = (stateStorage?.canRefreshCodeAfter ?? 0) <= 0
    }
}

private extension TimeInterval {
    var intValue: Int {
        Int(self)
    }
}
