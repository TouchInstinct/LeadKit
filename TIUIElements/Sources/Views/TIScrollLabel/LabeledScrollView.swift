import UIKit
import SnapKit

open class LabeledScrollView: BaseInitializableScrollView {

    private let textLabel = UILabel()
    private let contentView = UIView()

    // MARK: - Configurable Properties

    public var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }

    public var textColor: UIColor = .black {
        didSet {
            textLabel.textColor = textColor
        }
    }
    
    public var font: UIFont = UIFont.systemFont(ofSize: 13) {
        didSet {
            textLabel.font = font
        }
    }

    public var textAligment: NSTextAlignment = .center {
        didSet {
            textLabel.textAlignment = textAligment
        }
    }

    // MARK: - Initialization

    open override func addViews() {
        super.addViews()
        
        addSubview(contentView)
        contentView.addSubview(textLabel)
    }

    open override func configureAppearance() {
        super.configureAppearance()
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        clipsToBounds = true
        
        textLabel.numberOfLines = 0
        textLabel.textAlignment = textAligment
        textLabel.textColor = textColor
        textLabel.font = font
    }

    open override func configureLayout() {
        super.configureLayout()

        contentView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        let contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let contentViewCenterYConstraint = contentView.centerYAnchor.constraint(equalTo: centerYAnchor)
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: heightAnchor)

        [
            contentViewBottomConstraint,
            contentViewCenterYConstraint,
            contentViewHeightConstraint
        ].forEach { $0.priority = .defaultLow }

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentViewBottomConstraint,
            contentViewCenterYConstraint,
            contentViewHeightConstraint
        ])

        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
}
