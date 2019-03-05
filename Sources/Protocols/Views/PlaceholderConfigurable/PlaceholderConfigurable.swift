//
//  Copyright (c) 2018 Touch Instinct
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

import UIKit.UIView

/// Protocol that defines attributes and methods for view with placeholder and regular state.
public protocol PlaceholderConfigurable {

    associatedtype ContentContainerViewType: UIView
    associatedtype PlaceholderContainerViewType: UIView

    /// A view that will be shown when content will be received.
    var contentContainerView: ContentContainerViewType { get }
    /// A view that will be shown during loading content.
    var placeholderContainerView: PlaceholderContainerViewType { get }

    associatedtype ContentViewModelType
    associatedtype PlaceholderViewModelType

    typealias ContentLoadingViewModelType = ContentLoadingViewModel<ContentViewModelType, PlaceholderViewModelType>

    /// Configures view with content loading view model.
    ///
    /// - Parameter contentLoadingViewModel: Content loading view model with placeholder or content state.
    func configureContentLoading(with contentLoadingViewModel: ContentLoadingViewModelType)

    /// Configures view with content view model.
    ///
    /// - Parameter contentViewModel: Content view model to configure content state.
    func configure(contentViewModel: ContentViewModelType)

    /// Configures view with placeholder view model.
    ///
    /// - Parameter placeholderViewModel: Placeholder view model to configure placeholder state.
    func configure(placeholderViewModel: PlaceholderViewModelType)
}
