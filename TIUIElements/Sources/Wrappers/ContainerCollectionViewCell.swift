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

open class ContainerCollectionViewCell<View: UIView>: UICollectionViewCell, InitializableViewProtocol, WrappedViewHolder {
    // MARK: - WrappedViewHolder

    public private(set) lazy var wrappedView = createView()

    public var contentInsets: UIEdgeInsets = .zero {
        didSet {
            contentEdgeConstraints?.update(from: contentInsets)
        }
    }

    private var contentEdgeConstraints: EdgeConstraints?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeView()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        initializeView()
    }

    // MARK: - InitializableView

    open func addViews() {
        addSubview(wrappedView)
    }

    open func bindViews() {
        // override in subclass
    }

    open func configureLayout() {
        contentEdgeConstraints = configureWrappedViewLayout()
    }

    open func configureAppearance() {
        // override in subclass
    }

    open func localize() {
        // override in subclass
    }

    open func createView() -> View {
        return View()
    }
}
