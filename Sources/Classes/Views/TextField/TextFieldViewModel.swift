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

import RxSwift
import RxCocoa

/// Class that used for binding text field with upper level view model.
open class TextFieldViewModel<ViewEvents: TextFieldViewEvents,
                              ViewModelEvents: TextFieldViewModelEvents> {

    /// Events that can be emitted by view model.
    public let viewModelEvents: ViewModelEvents

    private let viewEventsVariable = Variable<ViewEvents?>(nil)

    private(set) public var disposeBag = DisposeBag()

    /// Initializer with view model events.
    ///
    /// - Parameter viewModelEvents: Events that can be emitted by view model.
    public init(viewModelEvents: ViewModelEvents) {
        self.viewModelEvents = viewModelEvents
    }

    /// View events driver that will emit view events structure
    /// when view will bind itself to the view model.
    public var viewEventsDriver: Driver<ViewEvents> {
        return viewEventsVariable
            .asDriver()
            .flatMap { viewEvents -> Driver<ViewEvents> in
                guard let viewEvents = viewEvents else {
                    return .empty()
                }

                return .just(viewEvents)
            }
    }

    /// Method that performs binding view events to view model.
    ///
    /// - Parameter viewEvents: View events structure.
    public func bind(viewEvents: ViewEvents) {
        viewEventsVariable.value = viewEvents
    }

    /// Unbinds view from view model.
    public func unbindView() {
        disposeBag = DisposeBag()
    }

}

public extension TextFieldViewModel {

    typealias MapViewEventsClosure = (ViewEvents) -> Disposable

    /// Convenient method for binding to the current view events structure.
    ///
    /// - Parameter closure: Closure that takes a view events parameter and returns Disposable.
    /// - Returns: Disposable object that can be used to unsubscribe the observer from the binding.
    func mapViewEvents(_ closure: @escaping MapViewEventsClosure) -> Disposable {
        return viewEventsDriver
            .map { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                closure($0).disposed(by: strongSelf.disposeBag)
            }
            .drive()
    }

}
