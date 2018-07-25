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

import TableKit

/// Base table controller configurable with view model and TableViewWrapperView as custom view.
open class BaseTableContentController<ViewModel>: BaseScrollContentController<ViewModel, TableViewWrapperView> {

    /// TableDirector binded to table view.
    public let tableDirector: TableDirector

    /// Initializer with view model, table view holder and table director parameters.
    ///
    /// - Parameters:
    ///   - viewModel: A view model to configure this controller.
    ///   - tableViewHolder: A view that contains table view.
    ///   - tableDirector: Custom TableDirector instance or nil to use the default one.
    public init(viewModel: ViewModel,
                tableViewHolder: TableViewWrapperView = .init(tableViewStyle: .plain),
                tableDirector: TableDirector? = nil) {

        self.tableDirector = tableDirector ?? TableDirector(tableView: tableViewHolder.tableView)

        super.init(viewModel: viewModel,
                   customView: tableViewHolder)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func configureAppearance() {
        super.configureAppearance()

        tableView.separatorStyle = .none
    }

    /// Contained UITableView instance.
    public var tableView: UITableView {
        return customView.tableView
    }

}
