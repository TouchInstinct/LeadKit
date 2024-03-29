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

import UIKit
import TIUIKitCore

open class ContainerTableViewCell<View: UIView>: BaseInitializableCell, WrappedViewHolder {
    // MARK: - WrappedViewHolder

    public private(set) lazy var wrappedView = createView()

    public var contentInsets: UIEdgeInsets = .zero {
        didSet {
            contentEdgeConstraints?.update(from: contentInsets)
        }
    }

    private var contentEdgeConstraints: EdgeConstraints?

    // MARK: - InitializableView

    override open func addViews() {
        super.addViews()

        contentView.addSubview(wrappedView)
    }

    override open func configureLayout() {
        super.configureLayout()

        contentEdgeConstraints = configureWrappedViewLayout()
    }

    open func createView() -> View {
        return View()
    }

    // MARK: - Open methods

    public func configureContainerTableViewCell(appearance: BaseWrappedViewHolderAppearance<some WrappedViewAppearance, some ViewLayout>) {
        contentInsets = appearance.subviewAppearance.layout.insets
        configureUIView(appearance: appearance)
    }
}

// MARK: - AppearanceConfigurable

extension ContainerTableViewCell: AppearanceConfigurable where View: AppearanceConfigurable,
                                                               View.Appearance: WrappedViewAppearance {

    public func configure(appearance: DefaultWrappedViewHolderAppearance<View.Appearance, UIView.NoLayout>) {
        configureContainerTableViewCell(appearance: appearance)
        wrappedView.configure(appearance: appearance.subviewAppearance)
    }
}
