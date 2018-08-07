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

/// Layoutless placeholder view. This class is used as views holder & configurator.
/// You should inherit it and implement layout.
open class BasePlaceholderView: UIView, InitializableView {

    /// Title label of placeholder view.
    public let titleLabel = UILabel()
    /// Description label of placeholder view.
    public let descriptionLabel = UILabel()

    /// Center image view of placeholder view.
    public let centerImageView = UIImageView()
    /// Action button of placeholder view.
    public private(set) lazy var button = createButton()

    /// Background image view of placeholder view.
    public let backgroundImageView = UIImageView()

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initializeView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subclass override

    /// Override to create your own subclass button.
    ///
    /// - Returns: UIButton (sub)class.
    open func createButton() -> UIButton {
        return UIButton()
    }

    // MARK: - InitializableView

    open func addViews() {
        // override in subclass
    }

    open func bindViews() {
        // override in subclass
    }

    open func configureAppearance() {
        // override in subclass
    }

    open func localize() {
        // override in subclass
    }

}

public extension BasePlaceholderView {

    /// Method for base configuration BasePlaceholderView instance.
    ///
    /// - Parameter viewModel: Placeholder view visual attributes without layout.
    func baseConfigure(with viewModel: BasePlaceholderViewModel) {
        titleLabel.configure(with: viewModel.title)

        descriptionLabel.isHidden = !viewModel.hasDescription
        viewModel.description?.configure(view: descriptionLabel)

        centerImageView.isHidden = !viewModel.hasCenterImage
        centerImageView.image = viewModel.centerImage

        viewModel.background.configure(backgroundView: self,
                                       backgroundImageView: backgroundImageView)

        button.isHidden = !viewModel.hasButton
        viewModel.buttonTitle?.configure(view: button)
    }

}
