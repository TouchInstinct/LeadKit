//
//  Copyright (c) 2019 Touch Instinct
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
import RxCocoa
import RxSwift

/// class that is a CustomizableButtonView subview and gives it a button functionality
open class CustomizableButton: UIButton {

    // MARK: - Constants

    private let defaultBackgroundColor = UIColor.white

    // MARK: - Background

    private var backgroundColors: [UIControl.State: UIColor] = [:] {
        didSet {
            updateBackgroundColor()
        }
    }

    func set(backgroundColors: [UIControl.State: UIColor]) {
        backgroundColors.forEach { setBackgroundColor($1, for: $0) }
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        backgroundColors[state] = color
    }

    func backgroundColor(for state: UIControl.State) -> UIColor? {
        return backgroundColors[state]
    }

    private func updateBackgroundColor() {
        if isEnabled {
            if isHighlighted {
                updateBackgroundColor(to: .highlighted)
            } else {
                updateBackgroundColor(to: .normal)
            }
        } else {
            updateBackgroundColor(to: .disabled)
        }
    }

    private func updateBackgroundColor(to state: UIControl.State) {
        if let stateColor = backgroundColor(for: state) {
            backgroundColor = stateColor
        } else if state != .normal, let normalStateColor = backgroundColor(for: .normal) {
            backgroundColor = normalStateColor
        } else {
            backgroundColor = defaultBackgroundColor
        }
    }

    // MARK: - Title

    func set(titleColors: [UIControl.State: UIColor]) {
        titleColors.forEach { setTitleColor($1, for: $0) }
    }

    func set(titles: [UIControl.State: String]) {
        titles.forEach { setTitle($1, for: $0) }
    }

    func set(attributtedTitles: [UIControl.State: NSAttributedString]) {
        attributtedTitles.forEach { setAttributedTitle($1, for: $0) }
    }

    // MARK: - Images

    func set(images: [UIControl.State: UIImage]) {
        images.forEach { setImage($1, for: $0) }
    }

    // MARK: - State

    override open var isEnabled: Bool {
        didSet {
            updateBackgroundColor()
        }
    }

    override open var isHighlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
}
