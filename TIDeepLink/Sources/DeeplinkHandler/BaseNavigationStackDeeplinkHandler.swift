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
import UIKit

open class BaseNavigationStackDeeplinkHandler: DeeplinkHandler {

    // MARK: - DeeplinkHandler

    open func canHandle(deeplink: DeeplinkType) -> Bool {
        findHandler(for: deeplink) != nil
    }

    open func handle(deeplink: DeeplinkType) -> Operation? {
        let handler = findHandler(for: deeplink)
        return handler?.handle(deeplink: deeplink)
    }

    // MARK: - Open methods

    open func findHandler(for deeplink: DeeplinkType) -> DeeplinkHandler? {
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }

        return rootController.findHandler(for: deeplink)
    }
}
