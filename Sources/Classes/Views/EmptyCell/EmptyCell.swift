//
//  Copyright (c) 2017 Touch Instinct
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
import TableKit

public final class EmptyCell: BaseCell, ConfigurableCell {

    private lazy var coloredView: UIView = {
        let newView = UIView()
        self.addSubview(newView)

        newView.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: newView.topAnchor).isActive           = true
        self.bottomAnchor.constraint(equalTo: newView.bottomAnchor).isActive     = true
        self.leadingAnchor.constraint(equalTo: newView.leadingAnchor).isActive   = true
        self.trailingAnchor.constraint(equalTo: newView.trailingAnchor).isActive = true

        return newView
    }()

    deinit {
        debugPrint("Deinit")
    }

    public func configure(with viewModel: EmptyCellViewModel) {
        configureSeparator(with: viewModel)
        coloredView.backgroundColor = viewModel.color
    }

}

