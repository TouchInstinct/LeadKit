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

import TIUIElements
import UIKit

open class LogEntryCellView: BaseInitializableView {

    public let containerView = UIStackView()
    public let timeLabel = UILabel()
    public let processLabel = UILabel()
    public let messageLabel = UILabel()
    public let levelTypeView = UIView()

    // MARK: - Life cycle

    open override func addViews() {
        super.addViews()

        containerView.addArrangedSubviews(timeLabel, processLabel)
        addSubviews(containerView,
                    messageLabel,
                    levelTypeView)
    }

    open override func configureLayout() {
        super.configureLayout()

        [containerView, timeLabel, processLabel, messageLabel, levelTypeView]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            messageLabel.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 8),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            messageLabel.trailingAnchor.constraint(equalTo: levelTypeView.leadingAnchor, constant: -8),

            levelTypeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            levelTypeView.centerYAnchor.constraint(equalTo: centerYAnchor),
            levelTypeView.heightAnchor.constraint(equalToConstant: 10),
            levelTypeView.widthAnchor.constraint(equalToConstant: 10),
        ])
    }

    open override func configureAppearance() {
        super.configureAppearance()

        containerView.axis = .vertical
        containerView.spacing = 4

        timeLabel.font = .systemFont(ofSize: 10)

        processLabel.lineBreakMode = .byTruncatingTail
        processLabel.font = .systemFont(ofSize: 12)

        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.font = .systemFont(ofSize: 12)

        levelTypeView.layer.cornerRadius = 3
    }
}
