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

import TIUIKitCore
import UIKit

public final class ContainerView<View: UIView>: BaseInitializableView, WrappedViewHolder {

    public var wrappedView = View()

    public var contentInsets: UIEdgeInsets = .zero {
        didSet {
            contentEdgeConstraints?.update(from: contentInsets)
        }
    }

    private var contentEdgeConstraints: EdgeConstraints?

    // MARK: - InitializableView

    public override func addViews() {
        super.addViews()

        addSubview(wrappedView)
    }

    public override func configureLayout() {
        super.configureLayout()

        contentEdgeConstraints = configureWrappedViewLayout()
    }
}

// MARK: - ConfigurableView

extension ContainerView: ConfigurableView where View: ConfigurableView {

    public func configure(with viewModel: View.ViewModelType) {
        wrappedView.configure(with: viewModel)
    }
}

// MARK: - AppearanceConfigurable

extension ContainerView: AppearanceConfigurable where View: AppearanceConfigurable,
                                                      View.Appearance: WrappedViewAppearance {

    public typealias Appearance = UIView.DefaultWrappedViewHolderAppearance<View.Appearance, UIView.DefaultWrappedLayout>

    public func configure(appearance: Appearance) {
        wrappedView.configure(appearance: appearance.subviewAppearance)
        configureUIView(appearance: appearance)
        contentInsets = appearance.subviewAppearance.layout.insets
    }
}
