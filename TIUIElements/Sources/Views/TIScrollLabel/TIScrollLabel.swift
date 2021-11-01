import UIKit
import TIUIElements

open class TIScrollLabel: BaseInitializableView {

    private let labeledScrollView = LabeledScrollView()

    open override func addViews() {
        super.addViews()
        
        addSubview(labeledScrollView)
    }

    open override func configureLayout() {
        super.configureLayout()

        labeledScrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labeledScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labeledScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labeledScrollView.topAnchor.constraint(equalTo: topAnchor),
            labeledScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
