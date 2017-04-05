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
import RxSwift

public protocol PaginationTableViewWrapperDelegate: class {

    associatedtype Cursor: ResettableCursorType

    func paginationWrapper(wrapper: PaginationTableViewWrapper<Cursor, Self>,
                           didLoad newItems: [Cursor.Element],
                           itemsBefore: [Cursor.Element])

    func paginationWrapper(wrapper: PaginationTableViewWrapper<Cursor, Self>,
                           didReload allItems: [Cursor.Element])

    func emptyPlaceholder(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> UIView

    func errorPlaceholder(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>,
                          forError error: Error) -> UIView

}

public extension PaginationTableViewWrapperDelegate {

    func emptyPlaceholder(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>) -> UIView {
        let placeholder = UIView()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "There is nothing here"

        placeholder.addSubview(label)
        label.centerXAnchor.constraint(equalTo: placeholder.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: placeholder.centerYAnchor).isActive = true

        return placeholder
    }

    func errorPlaceholder(forPaginationWrapper wrapper: PaginationTableViewWrapper<Cursor, Self>,
                          forError error: Error) -> UIView {

        let placeholder = UIView()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "An error has occurred"

        placeholder.addSubview(label)
        label.centerXAnchor.constraint(equalTo: placeholder.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: placeholder.centerYAnchor).isActive = true

        return placeholder
    }

}

public class PaginationTableViewWrapper<C: ResettableCursorType, D: PaginationTableViewWrapperDelegate>
where D.Cursor == C {

    public typealias PlaceholderTransform = (UIView, CGPoint) -> Void

    private let tableView: UITableView
    private let placeholdersContainerView: UIView
    private let paginationViewModel: PaginationViewModel<C>
    private weak var delegate: D?

    public var placeholderTransformOnScroll: PlaceholderTransform = { view, offset in
        var newFrame = view.frame
        newFrame.origin.y = -offset.y

        view.frame = newFrame
    }

    private let disposeBag = DisposeBag()

    public init(tableView: UITableView, placeholdersContainer: UIView, cursor: C, delegate: D) {
        self.tableView = tableView
        self.placeholdersContainerView = placeholdersContainer
        self.paginationViewModel = PaginationViewModel(cursor: cursor)
        self.delegate = delegate

        paginationViewModel.state.drive(onNext: { [weak self] state in
            switch state {
            case .initial:
                self?.onInitialState()
            case .loading:
                self?.onLoadingState()
            case .loadingMore:
                self?.onLoadingMoreState()
            case .results(let newItems, let after):
                self?.onResultsState(newItems: newItems, afterState: after)
            case .error(let error, let after):
                self?.onErrorState(error: error, afterState: after)
            case .empty:
                self?.onEmptyState()
            case .exhausted:
                self?.onExhaustedState()
            }
        })
        .addDisposableTo(disposeBag)
    }

    public func reload() {
        paginationViewModel.load(.reload)
    }

    private func onInitialState() {
        //
    }

    private func onLoadingState() {
        //
    }

    private func onLoadingMoreState() {
        //
    }

    private func onResultsState(newItems: [C.Element], afterState: PaginationViewModel<C>.State) {
        //
    }

    private func onErrorState(error: Error, afterState: PaginationViewModel<C>.State) {
        //
    }

    private func onEmptyState() {
        //
    }

    private func onExhaustedState() {
        //
    }

}
