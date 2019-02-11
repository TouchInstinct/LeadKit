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

import UIKit

/// Placeholder view visual attributes without layout.
open class BasePlaceholderViewModel {

    /// Title text with text attributes.
    public let title: ViewText
    /// Description text with text attributes.
    public let description: ViewText?
    /// Center image of placeholder.
    public let centerImage: UIImage?
    /// Button title with text attributes.
    public let buttonTitle: ViewText?
    /// Placeholder background.
    public let background: ViewBackground

    /// Memberwise initializer.
    ///
    /// - Parameters:
    ///   - title: Title text with text attributes.
    ///   - description: Description text with text attributes.
    ///   - centerImage: Center image of placeholder.
    ///   - buttonTitle: Button title with text attributes.
    ///   - background: Placeholder background.
    public init(title: ViewText,
                description: ViewText? = nil,
                centerImage: UIImage? = nil,
                buttonTitle: ViewText? = nil,
                background: ViewBackground = .color(.clear)) {

        self.title = title
        self.description = description
        self.centerImage = centerImage
        self.buttonTitle = buttonTitle
        self.background = background
    }
}

public extension BasePlaceholderViewModel {

    /// Returns true if description is not nil.
    var hasDescription: Bool {
        return description != nil
    }

    /// Returns true buttonTitle is not nil.
    var hasButton: Bool {
        return buttonTitle != nil
    }

    /// Returns true if centerImage is not nil.
    var hasCenterImage: Bool {
        return centerImage != nil
    }
}
