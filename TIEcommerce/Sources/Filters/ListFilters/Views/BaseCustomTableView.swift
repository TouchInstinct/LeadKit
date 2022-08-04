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

import TableKit
import TIUIElements
import TIUIKitCore
import UIKit

open class BaseCustomTableView: BaseInitializableView, UIScrollViewDelegate {

    private var tableViewEdgeContraints: EdgeConstraints!
    private var tableViewHeightConstraint: NSLayoutConstraint!

    private lazy var tableDirector = TableDirector(tableView: tableView, scrollDelegate: self)

    public let tableView = UITableView(frame: .zero, style: .grouped)

    public weak var scrollableViewDelegate: UIScrollViewDelegate?

    open override func addViews() {
        super.addViews()

        addSubview(tableView)
    }

    open override func configureLayout() {
        super.configureLayout()

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableViewEdgeContraints = .init(leadingConstraint: tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                    trailingConstraint: tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                    topConstraint: tableView.topAnchor.constraint(equalTo: topAnchor),
                                    bottomConstraint: tableView.topAnchor.constraint(equalTo: topAnchor))

        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalTo: heightAnchor)

        NSLayoutConstraint.activate([
            tableViewEdgeContraints.allConstraints,
            [tableViewHeightConstraint]
        ].flatMap { $0 })
    }

    open override func configureAppearance() {
        super.configureAppearance()

        tableView.separatorStyle = .none

        [self, tableView].forEach { $0.backgroundColor = .white }
    }

    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollableViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }

    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollableViewDelegate?.scrollViewDidScroll?(scrollView)
    }

    open func updateTableView(_ section: TableSection) {
        tableDirector.replace(withSection: section)
    }
}
