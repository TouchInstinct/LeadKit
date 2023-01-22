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

import UIKit

public typealias DeeplinkHandlerViewController = DeeplinkHandler & UIViewController

public extension UIViewController {

    func findHandler<DeeplinkHandler: DeeplinkHandlerViewController>(
        for deeplink: DeeplinkHandler.DeeplinkType
    ) -> DeeplinkHandler? {

        if let deeplinksHandler = self as? DeeplinkHandler,
           let _ = deeplinksHandler.handle(deeplink: deeplink) {
            return deeplinksHandler
        }

        if let deeplinksHandler: DeeplinkHandler = presentedViewController?.findHandler(for: deeplink) {
            return deeplinksHandler
        }

        return findHandlerInViewHierarchy(for: deeplink)
    }

    private func findHandlerInViewHierarchy<DeeplinkHandler: DeeplinkHandlerViewController>(
        for deeplink: DeeplinkHandler.DeeplinkType
    ) -> DeeplinkHandler? {

        switch self {
        case let navController as UINavigationController:
            let deeplinksHandler: DeeplinkHandler? = navController.viewControllers.reversed().findHandler(for: deeplink)
            return deeplinksHandler

        case let tabController as UITabBarController:
            if let deeplinksHandler: DeeplinkHandler = tabController.selectedViewController?.findHandler(for: deeplink) {
                return deeplinksHandler
            } else if var tabControllers = tabController.viewControllers {
                if tabController.selectedIndex != NSNotFound {
                    tabControllers.remove(at: tabController.selectedIndex)
                }

                if let deeplinksHandler: DeeplinkHandler = tabControllers.findHandler(for: deeplink) {
                    return deeplinksHandler
                }
            }

        default:
            return nil
        }

        return nil
    }
}

private extension Sequence where Element: UIViewController {
    func findHandler<DeeplinkHandler: DeeplinkHandlerViewController>(
        for deeplink: DeeplinkHandler.DeeplinkType
    ) -> DeeplinkHandler? {

        for controller in self {
            if let deeplinksHandler: DeeplinkHandler = controller.findHandler(for: deeplink) {
                return deeplinksHandler
            }
        }
        return nil
    }
}