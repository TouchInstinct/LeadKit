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

internal final class TextWithButtonPlaceholder: UIView {

    typealias TapHandler = () -> Void

    private let tapHandler: TapHandler

    init(title: TextPlaceholderView.PlaceholderText,
         buttonTitle: TextPlaceholderView.PlaceholderText,
         tapHandler: @escaping TapHandler) {

        self.tapHandler = tapHandler

        super.init(frame: .zero)

        let textPlaceholder = TextPlaceholderView(title: title)

        let button = UIButton(type: .custom)
        button.backgroundColor = .lightGray
        button.setTitle(buttonTitle.rawValue, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [textPlaceholder, button])
        stackView.axis = .vertical

        addSubview(stackView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonDidTapped(_ button: UIButton) {
        tapHandler()
    }

}
