import UIKit
import TIUIKitCore

open class BaseInitializableControl: UIControl, InitializableViewProtocol {
    override public init(frame: CGRect) {
        super.init(frame: frame)

        initializeView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initializeView()
    }

    // MARK: - InitializableView

    open func addViews() {
        // override in subclass
    }

    open func configureLayout() {
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
