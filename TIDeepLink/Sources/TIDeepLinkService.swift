//
//  Copyright (c) 2023 Touch Instinct
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

public final class TIDeeplinksService {

    public static let shared = TIDeeplinksService()

    // MARK: - Private properties

    private let operationQueue = OperationQueue.main

    private var pendingDeeplink: DeeplinkType?

    private(set) var isProcessDeeplink = false

    // MARK: - Public properties

    public var deeplinkMapper: DeeplinkMapper?
    public var deeplinkHandler = BaseNavigationStackDeeplinkHandler()

    // MARK: - Init

    private init() {

    }

    // MARK: - Public methods

    @discardableResult
    public func deferredHandle(url: URL) -> Bool {
        pendingDeeplink = deeplinkMapper?.map(url: url)
        return pendingDeeplink != nil
    }

    public func reset() {
        operationQueue.cancelAllOperations()
        pendingDeeplink = nil
        isProcessDeeplink = false
    }

    public func tryHandle() {
        guard let deeplink = pendingDeeplink,
              deeplinkHandler.canHandle(deeplink: deeplink) else {
            return
        }

        handle()
    }

    public func handle() {
        guard let deeplink = pendingDeeplink,
              let lastOperation = deeplinkHandler.handle(deeplink: deeplink) else {
            return
        }

        operationQueue.addOperation { [weak self] in
            self?.isProcessDeeplink = true
            self?.pendingDeeplink = nil
        }
        operationQueue.addOperations(lastOperation.flattenDependencies + [lastOperation],
                                     waitUntilFinished: false)
        operationQueue.addOperation { [weak self] in
            self?.isProcessDeeplink = false
        }
    }
}
