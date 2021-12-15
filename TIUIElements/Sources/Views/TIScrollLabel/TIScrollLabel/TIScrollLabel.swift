//
//  Copyright (c) 2021 Touch Instinct
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
import TIUIElements

open class TIScrollLabel: BaseInitializableScrollView {

    private let textLabel = UILabel()
    private let contentView = UIView()

    // MARK: - Configurable Properties

    public var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }

    public var attributedText: NSAttributedString? = nil {
        didSet {
            textLabel.attributedText = attributedText
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

    public var textAlignment: NSTextAlignment = .center {
        didSet {
            textLabel.textAlignment = textAlignment
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
        textLabel.textAlignment = textAlignment
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
