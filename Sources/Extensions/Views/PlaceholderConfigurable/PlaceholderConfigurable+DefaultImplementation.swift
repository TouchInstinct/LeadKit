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

public extension PlaceholderConfigurable {

    func configureContentLoading(with contentLoadingViewModel: ContentLoadingViewModelType) {
        switch contentLoadingViewModel {
        case .content(let contentViewModel):
            configure(contentViewModel: contentViewModel)
        case .placeholder(let placeholderViewModel):
            configure(placeholderViewModel: placeholderViewModel)
        }

        setPlaceholder(visible: contentLoadingViewModel.isPlaceholder)
    }

    func configure(placeholderViewModel: PlaceholderViewModelType) {
        // typically nothing
    }

    /// Shows or hides placeholder.
    ///
    /// - Parameter visible: A Boolean value that determines whether the placeholder content is visible.
    func setPlaceholder(visible: Bool) {
        contentContainerView.isHidden = visible
        placeholderContainerView.isHidden = !visible
    }

    /// Creates content view model for this type.
    ///
    /// - Parameter contentViewModel: Content of ContentLoadingViewModel.
    /// - Returns: ContentLoadingViewModel with content.
    static func content(with contentViewModel: ContentViewModelType) -> ContentLoadingViewModelType {
        return .content(contentViewModel)
    }

}
