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

public protocol PaginationTableViewWrapperDelegate: class {

    associatedtype Cursor: ResettableCursorType

    func paginationWrapper(wrapper: PaginationTableViewWrapper<Cursor, Self>,
                           didLoad newItems: [Cursor.Element],
                           itemsBefore: [Cursor.Element])

    func paginationWrapper(wrapper: PaginationTableViewWrapper<Cursor, Self>,
                           didReload allItems: [Cursor.Element])

}

public class PaginationTableViewWrapper<C: ResettableCursorType, D: PaginationTableViewWrapperDelegate>
where D.Cursor == C {

    private let tableView: UITableView

    private let paginationViewModel: PaginationViewModel<C>

    private weak var delegate: D?

    public init(tableView: UITableView, cursor: C, delegate: D) {
        self.tableView = tableView
        self.paginationViewModel = PaginationViewModel(cursor: cursor)
        self.delegate = delegate
    }

}
